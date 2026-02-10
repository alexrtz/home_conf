FROM ubuntu:24.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    bzip2 \
    ninja-build \
    git \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Install micromamba
RUN curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest \
    | tar -xvj -C /usr/local bin/micromamba

# Create non-root user with passwordless sudo
RUN groupadd cicd \
    && useradd -m -s /bin/bash -g cicd cicd \
    && echo 'cicd ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/cicd

USER cicd
WORKDIR /home/cicd

ENV MAMBA_ROOT_PREFIX=/home/cicd/micromamba

RUN micromamba shell init -s bash -r "$MAMBA_ROOT_PREFIX"

COPY --chown=cicd:cicd environment.yml /tmp/environment.yml

RUN micromamba create -n dev --file /tmp/environment.yml --yes \
    && micromamba clean --all --yes \
    && rm /tmp/environment.yml

ENV CONDA_PREFIX=$MAMBA_ROOT_PREFIX/envs/dev
ENV PATH=$CONDA_PREFIX/bin:$PATH
ENV LD_LIBRARY_PATH=/lib/x86_64-linux-gnu/:$CONDA_PREFIX/lib

# Create libtbb symlink if needed (matches setup.sh)
RUN if [ -f "$MAMBA_ROOT_PREFIX/envs/dev/lib/libtbb.so.12" ] \
    && [ ! -f "$MAMBA_ROOT_PREFIX/envs/dev/lib/libtbb.so" ]; then \
        ln -s "$MAMBA_ROOT_PREFIX/envs/dev/lib/libtbb.so.12" \
              "$MAMBA_ROOT_PREFIX/envs/dev/lib/libtbb.so"; \
    fi

CMD ["bash"]
