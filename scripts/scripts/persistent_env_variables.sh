need() {
    which "$1" &>/dev/null || notify-send "Binary '$1' is missing but required for $(basename ${BASH_SOURCE[0]})"
}

need "op"

op whoami > /dev/null 2>&1
if [ $? -ne 0 ]; then
    eval $(op signin)
fi

#if [ -z "${OPENAI_API_KEY}" ]; then
echo "export OPENAI_API_KEY='$(op read 'op://Our Vault/OpenAI/API_ARCH_DESKTOP')'" >> ~/.env
#else
#    notify-send "OPENAI_API_KEY already exists"
#fi

