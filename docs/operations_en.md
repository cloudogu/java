# Operating Cloudogu Java parent image features

## Additional certificates

The script `/usr/bin/create-ca-certificates.sh` enables relying dogus to automatically pull additional certificates from the the `etcd` keys and add them to the Java truststore.

There are two types of keys that are vital when addressing additional certificates:

- `/config/_global/certificate/additional/toc`.
   - this key contains the table of contents of aliases over additional certificates
   - single aliases are separated by spaces
- `/config/_global/certificate/additional/$alias`
   - these keys contain the desired certificates
   - if this certificate is to be addressed, the key name must appear in the above table of contents
   - **Important!** These keys must wrap a certificate's line breaks with `\n`

### Example configuration

The following example configuration in `etcd` shows how three additional certificates may be addressed with help of the `toc` key:

```
config/
└─ _global/
   └─ certificate/
      └─ additional/
         ├─ toc          -> "example.com localserver2 server3"
         ├─ example.com  -> "-----BEGIN CERTIFICATE-----\n...\n-----END CERTIFICATE-----"
         ├─ localserver2 -> "-----BEGIN CERTIFICATE-----\n...\n-----END CERTIFICATE-----"
         └─ server3      -> "-----BEGIN CERTIFICATE-----\n...\n-----END CERTIFICATE-----"
```

### Script usage

The script `/usr/bin/create-ca-certificates.sh` takes an optional parameter  which controls the path to the keystore.

Without parameter the keystore defaults to `/etc/ssl/truststore.jks`.

```bash
/usr/bin/create-ca-certificates.sh
```

Alternatively, an absolute path may be given. The following example creates the truststore at the provided path.

```bash
/usr/bin/create-ca-certificates.sh `/var/lib/yourdogu/yourtruststorename.jks`
```
