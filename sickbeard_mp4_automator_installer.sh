#!/bin/bash
pkg install -y ffmpeg py27-pip git
cd /usr/local/share
git clone https://github.com/mdhiggins/sickbeard_mp4_automator.git
cd sickbeard_mp4_automator
find . -iname "*.py" | xargs chmod +x
mv autoProcess.ini.sample autoProcess.ini
pip install "guessit<2"
pip install "subliminal<2"
pip install QTFastStart
