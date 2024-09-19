# Usamos la imagen base de Ubuntu
FROM ubuntu:20.04

# Establecemos las variables de entorno necesarias para evitar interacción en la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Actualizamos las dependencias del sistema
RUN apt-get update && apt-get upgrade -y

# Instalamos PHP y algunas dependencias necesarias
RUN apt-get install -y php libapache2-mod-php apache2

# Configuramos el archivo de Apache para que sirva index.php por defecto
RUN echo "<IfModule mod_dir.c>\n    DirectoryIndex index.php index.html\n</IfModule>" > /etc/apache2/mods-enabled/dir.conf

# Copiamos los archivos de la aplicación al directorio web de Apache
COPY . /var/www/html/

# Cambiamos los permisos del directorio web para que Apache pueda acceder a los archivos
RUN chown -R www-data:www-data /var/www/html

# Habilitamos el módulo de reescritura de Apache (por si es necesario)
RUN a2enmod rewrite

# Exponemos el puerto 80 para el servidor Apache
EXPOSE 80

# Iniciamos Apache en modo foreground
CMD ["apachectl", "-D", "FOREGROUND"]