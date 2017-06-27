
## replace
### eg 1
   repalce "ftp://mfs.jd.com/mnt/mfs/release/adserver/adserver-rb-149/14/ad_server_360buy.tgz"
   with    "ftp://mfs.jd.com/mnt/mfs/release/adserver/adserver-rb-149/23/ad_server_360buy.tgz"
```
sed 's/\(.*\)-149\/14\/\(.*\)/\1-149\/23\/\2/g' t?/bin.des
```

## add lines
### eg 2
```
sed -i 's/\[DEFAULT_INT_SET\]/&\n# ad position that donot need topup explosion ad in instaion\ninsta_pos_not_topup_explosion = 633,782/g' t?/query_server.ini
```
