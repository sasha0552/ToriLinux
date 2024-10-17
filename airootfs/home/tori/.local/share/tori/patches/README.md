> [!IMPORTANT]
> The DPSII patches have been superseded by the `nvidia-pstated` daemon, which can be found [here](https://github.com/sasha0552/nvidia-pstated). The daemon does not require application patching and switches performance states automatically.  
> **Patches in this directory will be removed at the end of this year.**

# ToriLinux patches

This directory contains various patches for various projects. They can be applied to a local copy of a project without installing/using ToriLinux.

## Applying

For example, suppose you want to apply patches to `llama.cpp`.

You need to download the desired patches, e.g. `0000-llamacpp-server-drop-pstate-in-idle.patch`.

To do this, run the following commands in terminal or CMD/Powershell (note that you need to replace `/` with `\` in the pathes if you are using Windows):

```sh
cd path/to/llama.cpp
git apply path/to/0000-llamacpp-server-drop-pstate-in-idle.patch
```

Don't forget to recompile the project if necessary!

## Patch types

### Drop PState In Idle (DPSII)

These patches can be used to automatically manage the performance states of NVIDIA GPUs using the [nvidia-pstate](https://github.com/sasha0552/nvidia-pstate).

Remember that you need to install `nvidia-pstate` in the virtual environment (if applicable), and/or add the executable to the system PATH.  
*Currently only `llama.cpp` uses `nvidia-pstate` executables from PATH. Other projects use `nvidia-pstate` as a library.*

This can reduce power consumption/temperatures, especially on server GPUs (note that SXM versions of server GPUs may not work).

For example, on my NVIDIA Tesla P40, these patches reduce power consumption from 50W to 10W (and temperature from 50C to ~25C (room temperature)) by setting the performance state to 8 when the application is idle. When a request comes in, it restores the driver behavior, so inference can run as usual.

This type of patch is currently available for these projects:

* [automatic](https://github.com/vladmandic/automatic)
* [llama.cpp](https://github.com/ggerganov/llama.cpp)
* [vllm](https://github.com/vllm-project/vllm)

### There were a few other patches earlier ...

... but they've now been merged into upstream projects or moved to my other repositories (e.g. [vllm-ci](https://github.com/sasha0552/vllm-ci)), so that's all for now.
