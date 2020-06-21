# Mac Text Encoder
A small text encoding conversion utility for macOS

<p align="center">
  <img src="https://github.com/xlfdll/xlfdll.github.io/raw/master/images/projects/MacTextEncoder.png"
       alt="Mac Text Encoder" width="720">
</p>

## Usage
This utility can be used for the following situations:
* Get representation of a string in different encodings
* Solve [Mojibake](https://en.wikipedia.org/wiki/Mojibake) issues

To use:
1. Type (or copy & paste) original text in **Source Text** field
2. Choose an encoding in **Source Encoding** box
   * This is for getting recognizable internal data (bytes) representation used in following steps
3. Choose an encoding in **Target Encoding** box
   * Such an encoding decodes the internal data (bytes) representation from step 2 to string
4. The result text will be shown in **Result Text** field

To resolve mojibake characters, one may need to tweak source and target encoding pairs to get correct / recognizable text.
