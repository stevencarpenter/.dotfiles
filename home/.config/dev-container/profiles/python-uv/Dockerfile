FROM python:3.12-slim-bookworm

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
    zsh \
    vim \
    gosu \
    libssl-dev \
    libffi-dev \
    pkg-config \
    python3-venv \
  && rm -rf /var/lib/apt/lists/*

# Install uv (astral) globally
RUN curl -LsSf https://astral.sh/uv/install.sh | sh -s -- --yes --bin-dir /usr/local/bin
ENV UV_SYSTEM_PYTHON=1

RUN groupadd --gid "${USER_GID}" "${USERNAME}" \
  && useradd --uid "${USER_UID}" --gid "${USER_GID}" --create-home --shell /bin/zsh "${USERNAME}" \
  && mkdir -p /work

WORKDIR /work
COPY common/dev-entrypoint.sh /usr/local/bin/dev-entrypoint
RUN chmod +x /usr/local/bin/dev-entrypoint
ENTRYPOINT ["dev-entrypoint"]
CMD ["/bin/zsh"]
