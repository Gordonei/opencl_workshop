# Workshop Instance Setup Notes

## AWS

1. Start up GPU Instance with Ubuntu 16.04 AMI (ami-1967056a in eu-west-1) with an extra EBS volume as device `/dev/svdf`. Make sure the security group is open on port 22 and port 10000.
2. Log into instance: `ssh -i /path/to/private/key ubuntu@instance.ip`
3. Create a mount point for the extra volume and make it writeable by the user: `mkdir /data && chown -r ubuntu:ubuntu /data`
4. Add an entry to the fstab for the extra volume: `echo "/dev/xvdf       /data   auto    defaults,nofail 0 2" | sudo tee -a /etc/fstab`
5. Mount the device: `sudo mount /data`
*Note - the first time the volume is used, the file system will need to be initialised prior to mounting: `sudo mkfs -t ext4 /dev/xvdf`*

## NVIDIA OpenCL

1. Update and install aptitude: `sudo apt-get update && sudo apt-get upgrade && sudo apt-get install aptitude`
2. Install NVIDIA support and CLInfo from Ubuntu Repos: `sudo aptitude install nvidia-361 clinfo nvidia-opencl-dev`
3. Download the latest NVIDIA drivers: `wget http://us.download.nvidia.com/XFree86/Linux-x86_64/367.35/NVIDIA-Linux-x86_64-367.35.run`
4. Change permissions and run: `chmod +x NVIDIA-Linux-x86_64-367.35.run && sudo ./NVIDIA-Linux-x86_64-367.35.run`
5. Use `clino | grep 'NVIDIA CUDA'` to check that NVIDIA is appearing as one of the platforms.

## Intel OpenCL

1. Download the latest Intel drivers: `wget http://registrationcenter-download.intel.com/akdlm/irc_nas/9019/opencl_runtime_16.1.1_x64_ubuntu_6.4.0.25.tgz`
2. Extract the resulting package: `tar -xf opencl_runtime_16.1.1_x64_ubuntu_6.4.0.25.tgz`
3. Install the required dependencies and run the installer in Command Line Mode: `sudo aptitude install lsb-core && sudo ./opencl_runtime_16.1.1_x64_ubuntu_6.4.0.25/install.sh --cli-mode`
4. Use `clino | grep 'Intel(R) OpenCL'` to check that Intel is appearing as one of the platforms.

## Numpy, SciPy, Matplotlib and PyOpenCL

1. Install Python3's pip and Tkinter support: `sudo aptitude install python3-pip python3-tk`
2. Make Python3 and Pip3 the defaults for the user shell: `echo 'alias python=python3' >> ~/.bashrc && echo 'alias pip=pip3' >> ~/.bashrc`
3. Install PyOpenCL dependency: `sudo aptitude install libffi-dev`
4. Install Numpy, Scipy, Matplotlib and PyOpenCL: `sudo pip3 install numpy scipy matplotlib pyopencl`  
5. Test that PyOpenCL is seeing both the NVIDIA and Intel OpenCL platforms: `python -c "import pyopencl;print([platform.name for platform in pyopencl.get_platforms()])"`

## Jupyer Notebook

1. Install Jupyter: `sudo pip3 install jupyter`
2. Generate a Jupyter configuration: `mkdir -p ~/.jupyter && touch ~/.jupyter/jupyter_notebook_config.py` 
3. Generate a hashed password and add it to the Jupyter config: `python -c "from notebook.auth import passwd;ret=passwd();print("c.NotebookApp.password = u\'%s\'"%ret)" >> ~/.jupyter/jupyter_notebook_config.py`
4. Generate a self-signed cert using OpenSSL: `openssl req -x509 -nodes -days 36500 -newkey rsa:1024 -keyout ~/.jupyter/jupyter_key.key -out ~/.jupyter/jupyter_cert.pem`
5. Add the key and cert to the Jupyter config: `echo c.NotebookApp.certfile = u\'/home/ubuntu/.jupyter/jupyter_cert.pem\' >> ~/.jupyter/jupyter_notebook_config.py && echo c.NotebookApp.keyfile = u\'/home/ubuntu/.jupyter/jupyter_key.key\' >> ~/.jupyter/jupyter_notebook_config.py`
6. Open the notebook server up to all traffic on port 10000: `echo c.NotebookApp.ip = \'*\' >> ~/.jupyter/jupyter_notebook_config.py && echo c.NotebookApp.open_browser = False >> ~/.jupyter/jupyter_notebook_config.py && echo c.NotebookApp.port = 10000 >> ~/.jupyter/jupyter_notebook_config.py`
7. Configure the notebook to serve from the data directory created earlier: `echo c.NotebookApp.notebook_dir = \'/data\' >> ~/.jupyter/jupyter_notebook_config.py`
8. Start the notebook server: `jupyter notebook`
9. Open a browser to `https://instance.public.ip.or.hostname:10000` to test that it is working. The browser will probably complain about the self-signed certificates.
10. Set notebook server to start on boot: `sed '$ i\su ubuntu -c \"jupyter notebook --no-browser\"' /etc/rc.local | sudo tee /etc/rc.local`

## Resources
* [OpenCL on Linux](https://wiki.tiker.net/OpenCLHowTo)
* [NVIDIA Driver Download Page](http://www.nvidia.com/Download/index.aspx?lang=en-us)
* [Intel OpenCL Driver Download Page](https://software.intel.com/en-us/articles/opencl-drivers#core_xeon)
* [Jupyter Notebook Docs](http://jupyter-notebook.readthedocs.io/)
