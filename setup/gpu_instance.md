# GPU Instance Setup
1. Start up GPU Instance with Ubuntu 16.04 AMI (ami-1967056a in eu-west-1).
2. Log into instance: `ssh -i /path/to/private/key` ubuntu@instance.ip`
## NVIDIA OpenCL
3. Update and install aptitude: `sudo apt-get update && sudo apt-get upgrade`
4. Install NVIDIA support and CLInfo from Ubuntu Repos: `sudo aptitude install nvidia-361 clinfo nvidia-opencl-dev`
5. Download latest NVIDIA drivers: `wget http://us.download.nvidia.com/XFree86/Linux-x86_64/367.35/NVIDIA-Linux-x86_64-367.35.run`
6. Change permissions and run: `chmod +x NVIDIA-Linux-x86_64-367.35.run && sudo ./NVIDIA-Linux-x86_64-367.35.run`
7. Use clinfo to check that 'NVIDIA CUDA' is appearing as one of the platforms: `clinfo`
## Intel OpenCL
## PyOpenCL
## Jupyer Notebook
