# Publish an SBT project to Maven Central

* **user**: The username that was used when registering (Initial Setup)[http://central.sonatype.org/pages/ossrh-guide.html#initial-setup].
* **password**: The password that was used when registering (Initial Setup)[http://central.sonatype.org/pages/ossrh-guide.html#initial-setup].
* **private-key**: The PGP private key corresponding to your identity.
* **passphrase**: The passphrase corresponding to your private key. It will have to be provided as a one-liner with `\n` for the newlines (Eg: `-----BEGIN PGP PRIVATE KEY BLOCK-----\n\n******* .... ******\n-----END PGP PRIVATE KEY BLOCK-----`).
* **destination**: The destination of the artefact. Can be one of: `SNAPSHOT`, `RELEASE`. Defaults to **SNAPSHOT**
* **unattended**: If this is set to `true`, the artefact will be published to Maven Central without any manual intervention. If it is set to `false`, the actual steps of _Close_ and _Release_ will have to be taken manually. Defaults to **false**.

## Example

```
steps:
    - audienceproject/sbt-to-maven-central:
        user: admin
        password: hjj6sdfb2378caibca8cst675svs
        private-key: -----BEGIN PGP PRIVATE KEY BLOCK-----\n\n*******\n**********\n******** .... *******\n******\n-----END PGP PRIVATE KEY BLOCK-----
        passphrase: hjl8dsfu667dsfiuaf78atf86ac6ay8gy9c8a5c689sdvas79cda
        destination: RELEASE
        unattended: true
```
