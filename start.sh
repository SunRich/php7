#!/bin/bash
echo 'start apache..'
a2enmod rewrite
apache2-foreground
