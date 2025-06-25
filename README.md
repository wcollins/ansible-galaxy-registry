# 🚀 Private Ansible Galaxy Registry - Demo
A complete, ready-to-use private [Ansible Galaxy NG](https://github.com/ansible/galaxy_ng) setup for demonstrations and testing. Simply clone and run with docker-compose. This project was created to validate and demonstrate [private registry support in torero v1.3.0](https://docs.torero.dev/en/latest/releasenotes/#torero-130).

## Quick Start

1. Clone Repository
```bash
git clone https://github.com/yourusername/ansible-galaxy-registry.git \
    && cd ansible-galaxy-registry
```

2. Start Galaxy NG
```bash
docker-compose up -d
```

3. Initialize Galaxy NG (wait ~30 seconds after starting)
```bash
./scripts/init-galaxy.sh
```

4. Download community.docker collection
```bash
./scripts/build-collection.sh
```

```bash
5. Upload community.docker collection to private Galaxy
./scripts/upload-collection.sh
```

### Configuring _torero_
You can find documentation for installing torero [here.](https://docs.torero.dev/en/latest/installation/) Following installation, you can follow the following steps:

1. Create repository reference in torero's data store _(this repository is public)_:
```bash
torero create repository ansible-galaxy-registry --url https://github.com/wcollins/ansible-galaxy-registry.git 
```

1. Create secret within torero application, containing the password for our private Galaxy Registry:
```bash
torero create secret  galaxy --prompt-value
```

1. Create Ansible Galaxy registry reference in torero's data store:
```bash
torero create registry ansible-galaxy galaxy-private --url 'http://localhost:8080' --username admin --password-name galaxy
```

1. Create simple test service:
```bash
torero create service ansible-playbook example-playbook --repository ansible-galaxy-registry --playbook example-playbook.yml --registry galaxy-private
```

## Directory Structure
```
ansible-galaxy-registry/
├── docker-compose.yml          # Main compose file
├── ansible.cfg                 # Ansible configuration for private Galaxy
├── galaxy_ng/                  # Galaxy NG data and configuration
│   ├── settings/
│   │   └── settings.py         # Galaxy NG settings
│   ├── pulp_storage/           # Persistent storage
│   ├── pgsql/                  # PostgreSQL data
│   └── containers/             # Container storage
├── collections/                # Downloaded collections
├── scripts/                    # Utility scripts
│   ├── init-galaxy.sh          # Initialize Galaxy NG
│   ├── build-collection.sh     # Download community.docker collection
│   └── upload-collection.sh    # Upload to Galaxy
└── example-playbook.yml        # Example playbook
```

## Accessing Galaxy NG
- **URL**: http://localhost:8080
- **Username**: admin
- **Password**: galaxyadmin

## Testing the Setup

## Configuration Details

### Galaxy NG Settings
Located in `galaxy_ng/settings/settings.py`:
- Configured for demo use (no content approval required)
- Collection signing disabled for easier uploads
- Basic authentication enabled

### Docker Compose
- Uses official `pulp/pulp-galaxy-ng` image
- Persists all data in local directories
- Exposes port 8080 (configurable)
- Includes health checks

## Troubleshooting

### Container Won't Start
```bash
# Check logs
docker-compose logs galaxy_ng

# Ensure directories have correct permissions
chmod -R 777 galaxy_ng/
```

### Can't Upload Collections
```bash
# Verify Galaxy is ready
curl -u admin:galaxyadmin http://localhost:8080/api/galaxy/v3/

# Check namespace exists
docker-compose exec galaxy_ng pulpcore-manager shell -c \
  "from galaxy_ng.app.models import Namespace; print(Namespace.objects.all())"
```

### Authentication Issues
- Ensure using correct credentials (admin/galaxyadmin)
- Check ansible.cfg is in current directory
- Verify URL includes `/api/galaxy/` path

## Cleanup

```bash
# Stop containers
docker-compose down

# Remove all data (optional)
docker-compose down -v
rm -rf galaxy_ng/
```

## Security Note
This setup is configured for demonstration purposes with:
- Simple passwords
- No SSL/TLS
- Relaxed security settings

> [!CAUTION]
> **Do not use in production - this project is for demo purposes only**