resource "digitalocean_droplet" "nginx" {
  image 	= "ubuntu-20-04-x64"
  name 		= "nginx"
  region 	= var.location
  size 		= "s-1vcpu-1gb"
  ssh_keys 	= [data.digitalocean_ssh_key.terraform.id]
  
  connection {
    host 		= self.ipv4_address
    user 		= "root"
    type 		= "ssh"
    private_key = file(var.pvt_key)
    timeout 	= "2m"
  }
  
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
    ]
  }
  
  provisioner "file" {
    # Copies the nginx.conf file to /etc/nginx.conf
	source		= "conf/nginx.conf"
	destination	= "/etc/nginx/nginx.conf"
  }
}

output "nginx_droplet_ip" {
  value = digitalocean_droplet.nginx.ipv4_address
}

resource "digitalocean_droplet" "mariadb" {
  name   = "mariadb"
  region = var.location
  size   = "s-1vcpu-1gb"
  image  = "ubuntu-20-04-x64"

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file(var.pvt_key)
    host        = self.ipv4_address
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
	  "sudo debconf-set-selections <<< 'mariadb-server mysql-server/root_password password ${var.dbrootpwd}'",
      "sudo debconf-set-selections <<< 'mariadb-server mysql-server/root_password_again password ${var.dbrootpwd}'",
      "sudo apt-get install -y mariadb-server",
	  "sudo systemctl enable mariadb",
      "sudo systemctl start mariadb",
      "sudo mysql -e 'CREATE DATABASE ${var.dbname};'",
      "sudo mysql -e 'CREATE USER ''${var.dbuser}''@''localhost'' IDENTIFIED BY ''${var.dbuserpwd}'';'",
      "sudo mysql -e 'GRANT ALL PRIVILEGES ON ${var.dbname}.* TO ''${var.dbuser}''@''localhost'';'",
      "sudo mysql -e 'FLUSH PRIVILEGES;'",
    ]
  }
}

output "mariadb_droplet_ip" {
  value = digitalocean_droplet.mariadb.ipv4_address
}

resource "digitalocean_droplet" "redis" {
  name   = "redis"
  region = var.location
  size   = "s-1vcpu-1gb"
  image  = "ubuntu-20-04-x64"

  connection {
    host        = self.ipv4_address
	type        = "ssh"
    user        = "root"
    private_key = file(var.pvt_key)  # Path to your SSH private key
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y redis-server",
      "sudo systemctl enable redis-server",
      "sudo systemctl start redis-server",
    ]
  }
}

output "redis_droplet_ip" {
  value = digitalocean_droplet.redis.ipv4_address
}
