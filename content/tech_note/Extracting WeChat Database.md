https://www.cnblogs.com/pieces0310/p/4216182.html

Decrypting password-based encrypted backup data for Huawei smartphones  https://www.sciencedirect.com/science/article/pii/S1742287618304511

http://blog.digital-forensics.it/2019/07/huawei-backup-decryptor.html



https://support.redshield.co/hc/en-gb/articles/207523403-Decrypting-Secure-Archives-using-Linux-tar-gz-enc

https://www.tecmint.com/encrypt-decrypt-files-tar-openssl-linux/

```bash
openssl aes-256-cbc -d -in your_archive_filename.tar.gz.enc -out your_archive_filename.tar.gz
tar -zxvf your_archive_filename.tar.gz
```

```bash
openssl enc -d -aes256 -in secured.tar.gz | tar xz -C test
```

## Key Derivation Function

https://emn178.github.io/online-tools/sha256.html

Zeratul001 -> 50c2543b32f7cab1df156f5c05bbc53536dcf8456cdb90221f35210cc89edb74



https://en.wikipedia.org/wiki/PBKDF2





https://stackoverflow.com/questions/50899819/computing-a-test-hash-with-python-pbkdf2-hmac-sha256-salt-not-the-same-vaules

https://pythonguidecn.readthedocs.io/zh/latest/scenarios/crypto.html