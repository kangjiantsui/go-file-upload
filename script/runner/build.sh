docker build \
  --build-arg SSH_PRIVATE_KEY="$(cat /root/.ssh/id_ed25519)" \
  --build-arg SSH_PUBLIC_KEY="$(cat /root/.ssh/id_ed25519.pub)" \
  -t runner .
