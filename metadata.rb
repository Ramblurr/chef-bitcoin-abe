name             "bitcoin-abe"
maintainer       "Casey Link"
maintainer_email "unnamedrambler@gmail.com"
license          "GNU Affero General Public License"
description      "Installs/Configures bitcoin-abe"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"
recipe           "bitcoin-abe", "Installs bitcoin-abe"
supports debian
supports ubuntu
depends "python"
depends "postgresql"