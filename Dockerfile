FROM nginx:alpine

ENV NODE_VERSION=6.11.4

RUN apk add --update curl make gcc g++ python linux-headers libgcc libstdc++ binutils-gold git \
	&& cd /tmp \
	&& curl -sSL https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}.tar.gz | tar -xz \
	&& ls -l \
	&& cd node-v${NODE_VERSION} \
	&& ./configure --prefix=/usr --without-snapshot \
	&& make -j$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
	&& make install \
	&& cd / \
	&& npm install -g yarn \
	&& apk del curl make gcc g++ python linux-headers binutils-gold git \
	&& rm -rf /etc/ssl /node-${NODE_VERSION} /usr/include \
		/usr/share/man /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp \
		/usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html
