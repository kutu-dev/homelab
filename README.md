<div align="center">
<h1>Homelab</h1>

Kutu's personal selfhosting configuration and deployment files

</div>

These files, although public, are not intended for use by other people beyond their use as a reference. They're opinionated to the following technologies and providers:

- [Docker](https://www.docker.com/)
- [Docker Engine Swarm mode](https://docs.docker.com/engine/swarm/)
- [Porkbun](https://porkbun.com/)
- [Ansible](https://ansible.com)
- [Tailscale](https://tailscale.com/)

## Manual actions

Things that due to limitations with Ansible or for being more convenient by hand should be done in a new installation:

- Set up the secrets mentioned below.
- Log into Tailscale.

### Secrets

If you want to use this setup you will need to manually setup the following secrets:

- Change the root password from the default `r00tme` to something else.
- Copy the file [`services/porkbun-ddns/config.example.yaml`](./services/porkbun-ddns/config.example.yaml) to `services/porkbun-ddns/config.yaml` and modify everything inside `<<<` and `>>>`.
- Change the Ansible Vault file located at [`ansible/secrets.enc.yaml`](./ansible/secrets.enc.yaml) to a new one that has the following keys:
  - `traefik_porkbun_api_key`: Given at the Porkbun website
  - `traefik_porkbun_secret_api_key`: Given at the Porkbun website
  - `seafile_maria_db_root_password`: Any secure log alphanumeric string
- Copy the file [`services/seafile/.env.example`](./services/seafile/.env.example) to `services/seafile/.env` and modify everything inside `<<<` and `>>>`.
- The default admin user and password, default values:
    - Email address: `admin.placeholder@example.com`
    - Password: `CHANGE_ME`

## Licensing

All the files at this repository are licensed under the Mozilla Private License 2.0 as noted at the file [`MPL-2.0-LICENSE.txt`](./MPL-2.0-LICENSE.txt) or URL <https://www.mozilla.org/en-US/MPL/2.0/> otherwise noted.

The file located at [`ansible/sshd_config`](./ansible/sshd_config) is licensed under the GNU GENERAL PUBLIC LICENSE Version 3 as noted at the file [`GPL-3.0-LICENSE.txt`](./GPL-3.0-LICENSE.txt) or URL <https://www.gnu.org/licenses/gpl-3.0.txt>.
