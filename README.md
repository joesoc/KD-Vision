# KD Vision

**KD Vision** is a containerized analytics tool that captures and visualizes search analytics from Knowledge Discovery (KD) components and user interfaces. It uses Apache Superset for interactive dashboards, PostgreSQL for time-series data storage, Redis for Superset's async operations, and NGINX as a reverse proxy.

---

## 📦 Stack Components

| Component     | Purpose                                          |
|---------------|--------------------------------------------------|
| Apache Superset | Dashboarding & visual analytics (port 8088 → NGINX) |
| PostgreSQL     | Stores search and click analytics (port 55432)  |
| Redis          | Async support for Superset (port 6380)          |
| NGINX          | Reverse proxy already running on the server     |

---

## 📁 Project Directory Structure

```
/opt/kd-vision/
├── docker-compose.yml          # Docker services for KD Vision
├── build.sh                    # Prepares folder structure
├── run.sh                      # Starts KD Vision stack
├── stop.sh                     # Stops containers
├── status.sh                   # Shows container status
├── init-db.sql                 # SQL schema for search_analytics
├── nginx/
│   └── superset.conf           # NGINX reverse proxy config
└── README.md                   # This documentation
```

---

## 🚀 Deployment Guide

### 1. Clone or Prepare Project Folder

```bash
sudo mkdir -p /opt/kd-vision/nginx
sudo chown $USER:$USER /opt/kd-vision -R
cd /opt/kd-vision
```

### 2. Run Project Setup

```bash
./build.sh        # Prepares directory structure (no installs)
./run.sh          # Pulls and starts Superset, Postgres, Redis
```

---

## 🔌 Access Superset

Once the stack is running:

- URL: `http://<your-server-ip>/superset/`
- Login:
  - **Username:** `admin`
  - **Password:** `admin`

> Superset is reverse proxied through NGINX via `/superset/`.

---

## 🧱 Initialize Database Schema

To create the `search_analytics` table:

```bash
docker exec -i superset_postgres psql -U superset -d superset < /opt/kd-vision/init-db.sql
```

> This creates the schema for storing logs and user events (queries, clicks, response times, etc.)

---

## 📊 Table Schema: `search_analytics`

```sql
CREATE TABLE IF NOT EXISTS search_analytics (
    id SERIAL PRIMARY KEY,
    timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    user_id TEXT,
    session_id TEXT,
    query TEXT,
    clicked_item TEXT,
    source TEXT, -- e.g., 'ui', 'log', 'nifi'
    response_time_ms INTEGER,
    metadata JSONB
);
```

---

## ⚙️ Management Scripts

| Script       | Description                        |
|--------------|------------------------------------|
| `./build.sh` | Sets up project structure          |
| `./run.sh`   | Starts the KD Vision containers    |
| `./stop.sh`  | Stops the stack                    |
| `./status.sh`| Shows container status             |

---

## 🔐 Security Notes

- Change the default Superset admin password (`admin`).
- Superset is bound to `localhost:8088` and accessed only through NGINX.
- Use HTTPS on your NGINX configuration if exposing externally.
- Restrict ports in your AWS security group (allow only 443/22 as needed).

---

## 🧠 Maintainer

- **Project Name:** KD Vision
- **Author:** Vinay Joseph

---

## ✅ Next Steps

- Connect `search_analytics` table in Superset as a dataset.
- Build time-series charts & dashboards.
- Ingest real-time search/click logs using NiFi or API.


