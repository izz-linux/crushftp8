username=$1
clearpass=$2

user=$username
cmdpass=`java -jar /var/opt/CrushFTP8_PC/CrushFTP.jar -p DES $clearpass`
pass=`echo $cmdpass | awk '{print $12}'`

mkdir /var/opt/CrushFTP8_PC/users/MainUsers/$user

mkdir -p /home/ftp\ root/$user/incoming
mkdir /home/ftp\ root/$user/outgoing


cat > /var/opt/CrushFTP8_PC/users/MainUsers/$user/user.XML <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<userfile type="properties">
<!--    <last_logins>06/13/2017 06:24:55 PM,06/12/2017 02:57:46 PM,05/15/2017 01:13:49 PM,05/15/2017 01:11:20 PM</last_logins> -->
        <root_dir>/</root_dir>
        <username>$user</username>
        <password>$pass</password>
        <user_name>$user</user_name>
        <max_logins>0</max_logins>
        <real_path_to_user>./users/MainUsers/$user/</real_path_to_user>
        <version>1.0</version>
        <userVersion>6</userVersion>
</userfile>
EOL

cat > /var/opt/CrushFTP8_PC/users/MainUsers/$user/VFS.XML <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<VFS type="properties">
        <item name="/$user/">(write)(view)(rename)(resume)</item>
        <item name="/">(view)(resume)</item>
	<item name="/$user/outgoing/">((read)(write)(view)(rename)(resume)</item>
</VFS>
EOL

mkdir /var/opt/CrushFTP8_PC/users/MainUsers/$user/VFS

cat > /var/opt/CrushFTP8_PC/users/MainUsers/$user/VFS/$user <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<VFS type="vector">
        <VFS_subitem type="properties">
                <url>FILE://home/ftp root/$user/</url>
                <type>DIR</type>
        </VFS_subitem>
</VFS>
EOL
