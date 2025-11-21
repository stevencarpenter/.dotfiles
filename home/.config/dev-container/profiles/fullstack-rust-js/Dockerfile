FROM debian:bookworm-slim

ARG USERNAME=dev
ARG USER_UID=1000
ARG USER_GID=1000

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    git \
    openssh-client \
    gnupg \
    pkg-config \
    libssl-dev \
    python3 \
    python3-pip \
    unzip \
    zsh \
    vim \
    gosu \
    procps \
  && rm -rf /var/lib/apt/lists/*

# Node.js 20.x
RUN curl -fsSL https://deb.nodesource.com/setup_20.x -o /tmp/nodesource_setup.sh \
  && [ -s /tmp/nodesource_setup.sh ] \
  # Security note: The script is executed after download. Consider verifying its contents or source. \
  && bash /tmp/nodesource_setup.sh \
  && apt-get update \
  && apt-get install -y --no-install-recommends nodejs \
  && rm -rf /var/lib/apt/lists/*

# Global JS tooling useful for dev
RUN npm install -g npm@latest pnpm@latest vite typescript svelte-language-server

# Create default user; uid/gid will be remapped at runtime by entrypoint
RUN groupadd --gid "${USER_GID}" "${USERNAME}" \
  && useradd --uid "${USER_UID}" --gid "${USER_GID}" --create-home --shell /bin/zsh "${USERNAME}" \
  && mkdir -p /work

# Rust toolchain
ENV PATH="/home/${USERNAME}/.cargo/bin:${PATH}"
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --profile minimal \
  && rustup component add clippy rustfmt rust-analyzer

WORKDIR /work
COPY common/dev-entrypoint.sh /usr/local/bin/dev-entrypoint
RUN chmod +x /usr/local/bin/dev-entrypoint
ENTRYPOINT ["dev-entrypoint"]
CMD ["/bin/zsh"]
