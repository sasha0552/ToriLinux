# ToriLinux - Linux LiveCD for offline AI inference

LiveCD based on [ArchLinux](https://archlinux.org/) and includes following projects preinstalled, including its dependencies:
1. [automatic](https://github.com/vladmandic/automatic)
2. [koboldcpp](https://github.com/LostRuins/koboldcpp)
3. [llama.cpp](https://github.com/ggerganov/llama.cpp)
4. [SillyTavern-Extras](https://github.com/SillyTavern/SillyTavern-Extras)
5. [text-generation-webui](https://github.com/oobabooga/text-generation-webui)

## Features

1. Easy setup. Just boot the ISO and you will have working setup for inferencing LLMs/SD/etc.
2. Fully offline inference (if you are already have models)
3. Includes performance state switcher, for reducing temperatures when inference is not running.

## Installation

To install ToriLinux:
1. Install [Ventoy](https://ventoy.net/en/doc_start.html) on USB drive.
2. Download the latest ISO from [workflows](https://github.com/sasha0552/ToriLinux/actions) and copy it on USB drive.

Note that ToriLinux works only with NVIDIA GPUs. Please open an [issue](https://github.com/sasha0552/ToriLinux/issues/new), if you want ROCm (AMD GPUs) version, and I'll make it.

## Misc

You need models pre-downloaded on local hard drive or NFS server, or enough RAM and internet connection to download models directly into RAM.

Open [issue](https://github.com/sasha0552/ToriLinux/issues/new) if you want inclusion of any other AI-related project into ISO.
