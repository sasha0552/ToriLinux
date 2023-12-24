# ToriLinux - Linux LiveCD for offline AI inference

LiveCD distribution based on [ArchLinux](https://archlinux.org/) and currently includes the following projects preinstalled, along with their dependencies:
* [automatic](https://github.com/vladmandic/automatic)
* [koboldcpp](https://github.com/LostRuins/koboldcpp)
* [llama.cpp](https://github.com/ggerganov/llama.cpp)
* [SillyTavern-Extras](https://github.com/SillyTavern/SillyTavern-Extras)
* [text-generation-webui](https://github.com/oobabooga/text-generation-webui)
* [vllm](https://github.com/vllm-project/vllm)

If you would like to see another AI-related project included in ToriLinux, please open an [issue](https://github.com/sasha0552/ToriLinux/issues/new).

## Features

* Easy setup: just boot the ISO, and you will have a working setup for inferencing LLMs/SD/etc.
* Fully offline inference.
* Includes performance state switcher, which reduces GPU temperatures when inference is not running.

## Usage

To use ToriLinux:
1. Install [Ventoy](https://ventoy.net/en/doc_start.html) on a USB drive.
2. Download the latest ISO from [workflows](https://github.com/sasha0552/ToriLinux/actions?query=branch%3Amain) and copy it to the USB drive.
3. Boot from the USB drive (select it as the boot device in BIOS/UEFI).
4. Log in with the username `tori` and password `tori`. You can also use [SSH](https://en.wikipedia.org/wiki/Secure_Shell).

Please note that ToriLinux currently works only with NVIDIA GPUs. If you would like a ROCm (AMD GPUs) version, please open an issue, and I'll make one.

## Misc

Note that you need pre-downloaded models on a local hard drive or NFS server, or enough RAM and internet connection to download models directly into RAM.
