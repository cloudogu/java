# Funktionen des übergeordneten Cloudogu-Java-Images

## Zusätzliche Zertifikate

Das Skript `/usr/bin/create-ca-certificates.sh` ermöglicht abhängigen Dogus, automatisch zusätzliche Zertifikate aus den `etcd`-Schlüsseln zu beziehen und sie dem Java Truststore hinzuzufügen.

Es gibt zwei Arten von Schlüsseln, die bei der Adressierung von zusätzlichen Zertifikaten wichtig sind:

- `/config/_global/certificate/additional/toc`.
  - dieser Schlüssel enthält das Inhaltsverzeichnis der Aliasnamen über zusätzliche Zertifikate
  - einzelne Aliase werden durch Leerzeichen getrennt
- `/config/_global/certificate/additional/$alias`
  - diese Schlüssel enthalten die gewünschten Zertifikate
  - wenn dieses Zertifikat angesprochen werden soll, muss der Schlüsselname im obigen Inhaltsverzeichnis erscheinen
  - **Wichtig!** Diese Schlüssel müssen die Zeilenumbrüche eines Zertifikats mit `\n` umschließen.

### Beispielkonfiguration

Die folgende Beispielkonfiguration in `etcd` zeigt, wie drei zusätzliche Zertifikate mithilfe des `toc`-Schlüssels angesprochen werden können:

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

### Verwendung des Skripts

Das Skript `/usr/bin/create-ca-certificates.sh` nimmt einen optionalen Parameter entgegen, der den Pfad zum Keystore bestimmt.

Ohne Parameter wird der Keystore auf `/etc/ssl/truststore.jks` zurückgesetzt.

```bash
/usr/bin/create-ca-certificates.sh
```

Alternativ kann auch ein absoluter Pfad angegeben werden. Das folgende Beispiel erstellt den Truststore unter dem angegebenen Pfad.

```bash
/usr/bin/create-ca-certificates.sh `/var/lib/yourdogu/yourtruststorename.jks`
```
