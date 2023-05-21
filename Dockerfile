FROM debian:bullseye-slim

# Install basic tools available in apt repo
RUN apt update && \
    apt install -y ca-certificates curl gnupg lsb-release direnv vim gettext-base && \
    rm -rf /var/lib/apt/lists/*



# Install kustomize
RUN curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv5.0.1/kustomize_v5.0.1_linux_amd64.tar.gz  | tar xz && \
    mv kustomize /usr/local/bin/ && \
    chmod +x /usr/local/bin/kustomize

# Install kustomize plugin khelm
ENV KUSTOMIZE_PLUGIN_HOME=/kustomize/plugin
RUN mkdir -p /kustomize/plugin/khelm.mgoltzsche.github.com/v2/chartrenderer && \
    curl -fsSL https://github.com/mgoltzsche/khelm/releases/latest/download/khelm-linux-amd64 > /kustomize/plugin/khelm.mgoltzsche.github.com/v2/chartrenderer/ChartRenderer && \
    chmod +x /kustomize/plugin/khelm.mgoltzsche.github.com/v2/chartrenderer/ChartRenderer

# Install Helm
RUN curl -L https://get.helm.sh/helm-v3.11.3-linux-amd64.tar.gz | tar xz && \
    mv ./linux-amd64/helm /usr/local/bin/ && \
    chmod +x /usr/local/bin/helm && \
    rm -rf ./linux-amd64

WORKDIR /

ENTRYPOINT ["bash"]