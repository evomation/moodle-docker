# Moodle Docker Compose Example

This example shows how to run a complete Moodle 4.5.x stack using Docker Compose, based on the image [`brandkern/moodle`](https://hub.docker.com/r/brandkern/moodle).

It includes:

- A Moodle container (based on `php:8.3-apache`)
- A MariaDB 11.3 database (as recommended by Moodle)
- Persistent volumes for both Moodle data and the database

## ⚠️ Disclaimer

This image and documentation are provided "as is", without warranty of any kind. Use at your own risk.
No liability or responsibility is accepted for correctness, completeness, or potential damage caused by the use of this software.

---

## 🚀 How to Run

Make sure you have [Docker](https://www.docker.com/products/docker-desktop) and [Docker Compose](https://docs.docker.com/compose/) installed.

Then run:

```bash
docker-compose up -d
```

Open your browser and go to:

http://localhost:8080

You should see the Moodle installation screen.

---

## 🧱 Included Services

| Service      | Description                          | Port(s)       |
|--------------|--------------------------------------|----------------|
| moodle       | Moodle PHP+Apache server             | 8080:80        |
| db           | MariaDB 11.3 database                | internal only  |
| moodle-cron  | Background cron job runner for Moodle | no ports       |

---

## 🕒 Cron Job Support

Moodle requires a background task runner (cron) to function correctly.

This setup includes a separate container that automatically runs `cron.php` every 60 seconds.

No further configuration is needed – just make sure the service is running:

```bash
docker-compose ps
```

You should see a container called moodle-cron.

Logs can be viewed with:

```bash
docker compose logs moodle-cron
```

or

```bash
docker logs -f moodle-cron
```

---

## 🗃️ Volumes

- `moodledata`: Stores Moodle files outside the container (e.g., plugin data, cache)
- `dbdata`: Persistent database storage

These volumes ensure your data is preserved between container restarts.

---

## ⚙️ Environment Variables

See the `docker-compose.yml` for all available environment variables.

Minimum required:

- `DB_HOST`, `DB_NAME`, `DB_USER`, `DB_PASS`
- `WWWROOT` (URL of the Moodle site)

---

## 🛠 Notes

- The Moodle image is built and maintained by [Evomation](https://www.evomation.de)
- The MariaDB version used is `11.3`, the latest LTS release as recommended by Moodle
- You can customize ports, credentials, and volumes as needed

---

## 📄 License

Moodle is GPLv3. This Docker configuration is provided under the MIT license.
