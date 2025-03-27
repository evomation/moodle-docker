# Moodle Docker Image (4.5.x)

This repository builds a Docker image for [Moodle](https://moodle.org/) 4.5.x, based on the official source code from the Moodle GitHub repository.

It is intended for use in automated environments, and is maintained by [Evomation](https://www.evomation.de) and published under the [brandkern](https://hub.docker.com/u/brandkern) Docker Hub organization by Evomation.

## ⚠️ Disclaimer

This image and documentation are provided "as is", without warranty of any kind. Use at your own risk.  
No liability or responsibility is accepted for correctness, completeness, or potential damage caused by the use of this software.

---

## 📦 Available Docker Image

🧊 Docker Hub: **[brandkern/moodle](https://hub.docker.com/r/brandkern/moodle)**

| Tag              | Description                                  |
|------------------|----------------------------------------------|
| `4.5-latest`     | Always points to the latest `v4.5.x` release |
| `v4.5.3` (etc.)  | Pinned to a specific Moodle release          |

---

## 🧱 Features

- Based on [`php:8.3-apache`](https://hub.docker.com/_/php) (Debian)
- Pulls the latest `v4.5.x` Moodle release automatically
- Includes all required PHP extensions
- Supports MariaDB / MySQL
- Production-ready structure
- Works with `docker run` or `docker-compose`

---

## 🚀 Usage

### 🐳 Basic Run Example

```bash
docker run -d -p 8080:80 \
  -e DB_HOST=db \
  -e DB_NAME=moodle \
  -e DB_USER=moodleuser \
  -e DB_PASS=secret \
  -e WWWROOT=http://localhost:8080 \
  -v $(pwd)/moodledata:/var/www/moodledata \
  brandkern/moodle:4.5-latest
```

You need to provide a MariaDB (recommended version: `11.3`) or MySQL container separately.
You find `docker-compose.yml` example in the `compose` subfolder in this project.

---

## ⚙️ Environment Variables

| Variable    | Required | Description                                 |
|-------------|----------|---------------------------------------------|
| `DB_HOST`   | ✅        | Hostname of the database                    |
| `DB_NAME`   | ✅        | Moodle database name                        |
| `DB_USER`   | ✅        | Database username                           |
| `DB_PASS`   | ✅        | Database password                           |
| `WWWROOT`   | ✅        | Public URL of your Moodle instance          |

---

## 🕒 Cron Job Support

Moodle requires a background task runner to execute scheduled maintenance tasks such as sending emails, cleaning up sessions, and running plugin jobs.

This repository includes a dedicated `moodle-cron` container that automatically runs `cron.php` every 60 seconds.

To enable it, simply use the included [`docker-compose.yml`](compose/docker-compose.yml) setup. The cron container is already configured.

You can verify that it's running with:

```bash
docker-compose ps
```

And view its logs with:

```bash
docker logs -f moodle-cron
```

---

## 🔄 Auto-Updating

This image is automatically rebuilt using GitHub Actions when a new Moodle `v4.5.x` release is published.  
The current version is stored in `.latest-4.5-version` and passed into the Docker build as `MOODLE_TAG`.

---

## 🧪 Building & Publishing the Image Locally

You can build and publish the Moodle image manually, for example to test new versions or push custom changes to Docker Hub.

### 📌 1. Update the Moodle Version

To set the latest Moodle 4.5.x version, run the update script:

```bash
./scripts/update-latest-version.sh
```

This will fetch the latest Moodle 4.5.x release tag from the official Moodle Git repository and write it to the `.latest-4.5-version` file in the project root.

### 🏗️ 2. Build the Docker Image

Once `.latest-4.5-version` contains the correct version (e.g. `v4.5.3`), build the image locally and tag it for Docker Hub:

```bash
VERSION=$(cat .latest-4.5-version)

docker build \
  -t brandkern/moodle:4.5-latest \
  -t brandkern/moodle:$VERSION \
  .
```

> You can strip the `v` prefix from `$VERSION` if you prefer Semver-style Docker tags.

### 📤 3. Push the Image to Docker Hub

Push both tags to Docker Hub:

```bash
docker push brandkern/moodle:4.5-latest
docker push brandkern/moodle:$VERSION
```

### 🧼 4. Clean Up (Optional)

If desired, remove the local images after pushing:

```bash
docker image rm brandkern/moodle:4.5-latest brandkern/moodle:$VERSION
```

That’s it! You now have a fresh Moodle Docker image built and published manually. Ideal for development workflows, offline testing, or version control.

---

## 🤝 Maintainer

This image is built and maintained by  
**Michael Meese / Evomation**  
🔗 [www.evomation.de](https://www.evomation.de)  
🐋 Published on Docker Hub as [brandkern/moodle](https://hub.docker.com/r/brandkern/moodle)

---

## 📄 License

This image uses official Moodle source code (GPLv3).  
The Docker build files and automation are provided under the MIT license.

