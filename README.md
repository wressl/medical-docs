# medical-docs package for espanso
An [espanso](https://espanso.org) package to help with medical documentation

## Text-Expander for Medical Charting

With ever increasing demands on physician time, we need to make use of
technology to increase efficiency.
If we can spend less time on typing, we can spend more time listening
and caring for our patients.

Many electronic medical records (EMRs) provide the ability to create
templates or stamps.
Some of these functions actually work pretty well within each system.
However, they all require considerable investment in time to set up, and
collaboration on development is limited.
Templates may be shared within a clinic but seldom more widely.

Using a tool like espanso allows us to define templates/stamps and
automatic text expansion independent of any EMR.
This means you can document in a similar manner across different sites,
even if they are using different EMRs.  It also means a community of
interested individuals can collaborate to create a library that is
likely to be more complete and useful than anything any individual
can maintain on their own.

## Installation

1. Install [espanso](https://espanso.org)

2. Install medical-docs package
     `espanso install medical-docs`

3. Add the following to your default.yml
   Hint: found in the *Config* directory as listed by `espanso path`

```yml
# use clipboard to insert text
# should be smoother operation unless your application can't accept
# input from clipboard
backend: "Clipboard"

# global variables
global_vars:
  # your name to be included as appropriate
  - name: "myname"
    type: "dummy"
    params:
      echo: "Dr. Bill Ressl"

  # Some prefixes to implement patient facing documentation
  # chief complaint prefix: headache -> Your main concern today is headache
  - name: "cc"
    type: "dummy"
    params:
      echo: "Your main concern today is"
  # symptom prefix: no headache -> You have no headache
  - name: "sp"
    type: "dummy"
    params:
      echo: "You have"
  # symptom prefix: normal blood pressure -> You have normal blood pressure
  - name: "op"
    type: "dummy"
    params:
      echo: "You have"
  # symptom prefix: strep throat -> Your most likely diagnosis is strep throat
  - name: "ap"
    type: "dummy"
    params:
      echo: "Based on today's assessment, the most likely diagnosis is"
  # plan prefix: follow-up in 3 days -> You are recommended to follow-up in 3 days
  - name: "pp"
    type: "dummy"
    params:
      echo: "You are recommended to"
```

4. restart espanso
```
Macintosh-2:~ wressl$ espanso restart
Daemon started correctly!
```

## Usage

If the installation worked correctly, you should be able to start
typing with auto-magical results.

For example:
```
Macintosh-2:~ wressl$ xr
```
as soon as you hit `space`, turns into
```
Macintosh-2:~ wressl$ x-ray
```

Here is a list of all the current available expansions:

Simple Abbreviations    | Expansion
A:                      | Assessment:
bmd                     | bone mineral density
cp                      | chest pain
cxr                     | chest X-ray
fit test                | FIT test (colon cancer screen)
h                       | hours
L                       | Left
llq                     | left lower abdomen
luq                     | left upper abdomen
m                       | months
mammo                   | mammogram
min                     | minutes
O:                      | Objective:
P:                      | Plan:
R                       | Right
rlq                     | right lower abdomen
ruq                     | right upper abdomen
S:                      | Subjective:
sob                     | shortness of breath
sec                     | seconds
soboe                   | shortness of breath on exertion
u/s                     | ultrasound
w                       | weeks
y                       | years
ya                      | You are at home in
yh                      | You have had
ym                      | Your main concern today is
yn                      | You have had no
xr                      | x-ray

Components              | Description
:covidredflags          | Covid Red Flags
:covidsig               | Covid Reminder To Social Distance
:date                   | Current Date
:hitsh                  | Hypothyroid Symptoms
:lmom                   | Left message for patient
:lotsh                  | Hyperthyroid Symptoms
:neuroexam              | General Neurology Exam
:neuroredflag           | Neurology Red Flags
:pain                   | Pain History
:time                   | Current Time


Clinical Notes          | Description
:ankle                  | Ankle Pain
:back                   | Back Pain
:covidmonitor           | Covid Monitoring
:covidphone             | Covid Related Phone Call
:covidrisk              | Covid Risk Assessment
:delayedejac            | Delayed Ejaculation
:hairloss               | Hair Loss
:intro                  | Introductory Visit
:phone                  | Basic phone call
:strep                  | Strep Throat
:urti                   | Upper Respiratory Tract Infection
:uti                    | Urine Tract Infection
:vertigo                | Vertigo





## Contributors
If you are interested in becoming a contributor
contact me by [email](wressl@gmail.com)

## License

medical-docs was created by Bill Ressl
and is licensed under the [GPL-3.0 license](/LICENSE).
If you decide to use the contents outside of espanso,
contact me by [email](wressl@gmail.com)
