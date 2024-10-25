dnf search libvirt-* | sed -E 's/(.?)devel*//g' | sed -E 's/(\.noarch|\.x86_64|\.i686).*//'
