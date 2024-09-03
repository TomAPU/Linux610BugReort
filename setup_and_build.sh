#!/bin/bash
if [ ! -d "/output" ]; then
    echo "There is no /output directory. Please mount a directory to /output"
    exit 1
fi
apt update -y 
apt install -y wget build-essential xz-utils libssl-dev bc flex libelf-dev bison 
wget https://github.com/llvm/llvm-project/releases/download/llvmorg-14.0.0/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz -O clang_llvm.tar.xz 
tar -xf clang_llvm.tar.xz 
cp -r clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04/* /usr/local/ 
wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.10.tar.xz -O linux.tar.xz 
tar -xf linux.tar.xz 
mv linux-6.10 /linux 
wget https://raw.githubusercontent.com/TomAPU/Linux610BugReort/master/kernelconfig -O /linux/.config 
cd /linux 
make LLVM=1 -j$(nproc)
mv vmlinux /output && mv ./arch/x86/boot/bzImage /output
echo "Build complete. vmlinux and bzImage should be in /output"