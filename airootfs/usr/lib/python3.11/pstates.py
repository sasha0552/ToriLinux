import os
import subprocess

def _set_pstate(pstate):
  visible_devices = os.getenv("CUDA_VISIBLE_DEVICES")

  if visible_devices:
    for device in visible_devices.split(","):
      subprocess.check_call([ "nvidia-pstate", "-i", device, "-ps", pstate ], stdout=subprocess.DEVNULL)
  else:
    subprocess.check_call([ "nvidia-pstate", "-ps", pstate ], stdout=subprocess.DEVNULL)

def enter_pstate_low():
  _set_pstate("8")

def enter_pstate_high():
  _set_pstate("16")
