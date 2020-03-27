# Dockerfile
## Builds valadoc and serves it with a basic PHP server

# Build valadoc
FROM ubuntu:20.04 as build-docs

ENV DEBIAN_FRONTEND=noninteractive

# Install basic needed packages
RUN apt-get update -qq && apt-get install -qq --no-install-recommends software-properties-common

# Install third party repos
RUN add-apt-repository -y ppa:vala-team/daily

# Install valadoc and server packages
RUN apt-get update -qq && apt-get install \
  -qq \
  --no-install-recommends \
  gcc \
  libgee-0.8-dev \
  git \
  libguestfs-gobject-dev \
  libvaladoc-0.50-dev \
  php \
  php-curl \
  sphinxsearch \
  unzip \
  valac \
  valadoc \
  wget \
  xsltproc \
  make \
  nodejs \
  npm

# Copy over the valadoc stuff
COPY . /opt/valadoc
WORKDIR /opt/valadoc

# Build docs
RUN make build-docs || true

# Build search index
RUN make configgen \
  && ./configgen ./valadoc.org/ \
  && mkdir ./sphinx/storage \
  && indexer --config ./sphinx.conf --all

# Build website assets
RUN npm ci && make build-data

# Cleanup and publish
FROM php:apache

ENV DEBIAN_FRONTEND=noninteractive

# Install sphinxsearch for search index
RUN apt-get update -qq && apt-get install \
  -qq \
  --no-install-recommends \
  sphinxsearch

# Install the mysqli extension
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

# Copy over all of the valadoc sphinx search data and configuration
RUN mkdir -p /opt/valadoc
COPY --from=build-docs /opt/valadoc/sphinx.conf /opt/valadoc/sphinx.conf
COPY --from=build-docs /opt/valadoc/sphinx /opt/valadoc/sphinx

# Copy over the build static html files
COPY --from=build-docs /opt/valadoc/valadoc.org /var/www/html

# A couple default apache changes to make valadoc work
COPY apache.conf /etc/apache2/sites-available/000-default.conf

COPY docker-server.sh /usr/local/bin/valadoc.org
CMD ["valadoc.org"]
