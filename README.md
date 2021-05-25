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

2. Install emergency-medicine-docs package
     `espanso install emergency-medicine-docs`

3. Add the following to your default.yml
   Hint: found in the *Config* directory as listed by `espanso path`

```yml
# use clipboard to insert text
# should be smoother operation unless your application can't accept
# input from clipboard
# backend: "Clipboard"

# global variables
global_vars:
  # clinic name to be included as appropriate
  - name: "cname"
    type: "dummy"
    params:
      echo: "My Clinic Name"

  # your name to be included as appropriate
  - name: "myname"
    type: "dummy"
    params:
      echo: "Dr. Bill Ressl"

  # your email to be included as appropriate
  - name: "myemail"
    type: "dummy"
    params:
      echo: "wressl@gmail.com"

  # your phone number to be included as appropriate
  - name: "myphone"
    type: "dummy"
    params:
      echo: "1-800-123-4567"

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
  # covid website: local self-assessment site to request testing
  - name: "covidwebsite"
    type: "dummy"
    params:
      echo: "https://myhealth.alberta.ca/Journey/COVID-19"
  # find a family physician website: local
  - name: "findfpwebsite"
    type: "dummy"
    params:
      echo: "https://albertafindadoctor.ca/"
matches:
  # instructions on how to get your prescription
  - trigger: ":rxget"
    word: true
    replace: |
      Once your prescription has been written, you will receive a
      notification on your app.
      You then need to acknowledge the notification and select a pharmacy
      where the prescription will be sent.
      You need to select the pharmacy EVERY TIME you receive a prescription.
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
--------------          | ------------------
A:                      | Assessment:
amit                    | Amitriptyline (Elavil)
appt                    | appointment
bcp                     | birth control pill
:bid                    | twice daily
bmd                     | bone mineral density
bp                      | blood pressure
:cp                     | chest pain
cpl                     | Please copy the following link into your browser:
cv                      | COVID-19
cxr                     | chest X-ray
ds                      | drug-store
EOM                     | extraocular movements (EOM)
fit test                | FIT test (colon cancer screen)
fp                      | Family Physician
f/u                     | follow-up
hr                      | hours
labreq                  | Laboratory Requisition
Lt                      | Left
llq                     | left lower abdomen
lmp                     | last menstrual period
luq                     | left upper abdomen
mo                      | months
mammo                   | mammogram
min                     | minutes
:mycl                   | your clinic name
:myem                   | your email address
:myn                    | your name
:myph                   | your phone number
nc                      | Alberta Netcare
nort                    | Nortriptyline (Avantyl)
O:                      | Objective:
ocp                     | oral contraceptive pill
:od                     | once daily
oeph                    | On examination of the photo provided,
otc                     | over-the-counter
P:                      | Plan:
PERRLA                  | pupils equal, round, reactive to light and accomodation (PERRLA)
pf                      | puffs
pn                      | BC PharmaNet
prn                     | as needed
:qhs                    | at bed-time
:qid                    | four times daily
Rt                      | Right
rlq                     | right lower abdomen
ruq                     | right upper abdomen
rx                      | prescription
rxhld                   | Please do not fill until requested by patient
S:                      | Subjective:
sob                     | shortness of breath
sec                     | seconds
soboe                   | shortness of breath on exertion
:temp                   | temperature
:tid                    | three times daily
trx                     | Please take medication(s) prescribed as directed
u/s                     | ultrasound
valt                    | Valacyclovir (Valtrex)
vrx                     | 2-4 puffs four times daily as needed
vutd                    | vaccinations are up to date 
wic                     | walk-in clinic
wk                      | weeks
ya                      | You are at home in
yaa                     | You are at home in XXXX accompanied by your mother XXXX
yar                     | You are advised to
yfut                    | Your main concern today is to follow-up on test results
yh                      | You have had
ym                      | Your main concern today is
ymed                    | Your current medications include
ymnd                    | You  were accompanied by your mom and dad
ymhx                    | Your medical history significantly includes
yn                      | You have had no
ynhx                    | You have no previous significant medical history, no prescription medications and no relevant family history
yr                      | years
yrx                     | You are requesting a prescription for
yw                      | You appear well, with no apparent distress
xr                      | x-ray

Components              | Description
--------------          | ------------------
:arcause                | Causes of arrhythmia (6Hs,5Ts)
:asthma                 | Asthma ICS start
:cage                   | CAGE screen for ETOH abuse
:cialis                 | Cialis (tadalafil) start
:covidredflags          | Covid Red Flags
:covidremind            | Covid Reminder To Social Distance, Wash Hands, etc
:covidtest              | Recommend Covid Test
:cthead                 | Canadian CT Head Rule
:date                   | Current Date
:depain                 | Digital (Video) Exam for Pain
:demental               | Digital (Video) Exam for Mental Status
:depeds                 | Digital (Video) Exam for Pediatrics
:deresp                 | Digital (Video) Exam for Respiratory
:deabdo                 | Digital (Video) Exam for Abdomen
:eczemamgt              | Eczema care instructions
:finish                 | Finish to visit note (results, prescription, etc)
:findfp                 | Recommendation to find family physician
:FIFE                   | Feelings, Ideas, Function, Expectations
:fufp                   | Follow-up with your regular Family Physician
:fuwr                   | Follow-up when results are available
:gad7                   | GAD-7 questionnaire for anxiety
:gcs                    | Glasgow Coma Scale
:giredflag              | Gastrointestinal Red Flags
:headachefu             | Headache Follow-up Precautions
:headacheredflag        | Headache Red Flags
:hitsh                  | Hypothyroid Symptoms
:ibsmgt                 | IBS management suggestions
:ironho                 | Handout on Iron in Foods
:ksprevent              | Strategies to Prevent Kidney Stones
:life                   | General lifestyle advice
:lmom                   | Left message for patient
:lotsh                  | Hyperthyroid Symptoms
:lowtestinfo            | Low Testosterone Related Info
:menses                 | Menstrual History
:mse                    | Mental Status Exam
:neuroexam              | General Neurology Exam
:neuroredflag           | Neurology Red Flags
:noother                | No allergies, meds, med issues, etc
:OLDCARTS               | Pain History Acronym
:opsredflag             | Subjective Ophtho Red Flags
:oporedflag             | Objective Ophtho Red Flags
:pain                   | Pain History
:perc                   | PERC criteria to rule out PE
:phq9                   | PHQ-9 questionnaire for depression
:physio                 | recommendation for physiotherapy
:preprisk               | Pre-Exposure Prophylaxis (PrEP) for HIV Risk Score
:psylink                | Useful psychiatry links
:psylinkbc              | Useful psychiatry links specific to British Columbia
:psymed                 | General advice about antidepressants
:PQRST                  | Pain History Acronym
:refer                  | Referral sent
:results                | Explanation of results follow-up
:rice                   | Rest Ice Compression Elevation advice
:risksuicide            | Risk factors for suicide
:rxchiro                | Prescription for Chiropractor Treatment
:rxcompression          | Prescription for Compression Stockings
:rxget                  | Instructions for completing prescription
:rxkeflex               | Prescription for Cephalexin (Keflex)
:rxmassage              | Prescription for Massage Therapy
:rxmastitis             | Prescription for Topical Treatment for Mastitis
:rxorthotics            | Prescription for Custom Orthotics
:rxphysio               | Prescription for Physiotherapy
:sessri                 | Side effects of SSRIs
:sleephy                | Sleep Hygiene
:snet                   | General safety net advice
:snet2                  | Safety net advice while waiting for results
:SOCRATES               | Pain History Acronym
:stitest                | Recommendation for STI testing
:strepscore             | Strep Throat Score (McIsaac)
:sxetohwd               | Symptoms of ETOH withdrawal
:sxgad                  | Symptoms of Generalized Anxiety
:sxmania                | Symptoms of Mania
:sxmdd                  | Symptoms of Depression
:sxpanic                | Symptoms of Panic Attack
:time                   | Current Time
:tremorinfo             | Tremor Related Info
:wellsdvt               | Wells Score for DVT
:wellspe                | Wells Score for PE
:xray                   | X-ray being ordered

Clinical Notes          | Description
--------------          | ------------------
:abdopain               | Abdominal Pain
:ankle                  | Ankle Pain
:aub                    | Abnormal Uterine Bleeding
:back                   | Back Pain
:bellsp                 | Bell's Palsy
:canker                 | Canker (Aphthous Ulcer)
:chestpain              | Chest pain
:covidmonitor           | Covid Monitoring
:covidphone             | Covid Related Phone Call
:covidrisk              | Covid Risk Assessment
:delayedejac            | Delayed Ejaculation
:depression             | Depression
:driver                 | Driver's Medical
:excision               | Skin excision
:fatigue                | Fatigue
:ffertility             | Female infertility
:fluvac                 | Influenza vaccine visit
:gout                   | Gout
:hairloss               | Hair Loss
:headache               | Headache
:hernia                 | Hernia
:hsv                    | Herpes Simplex Virus
:ibs                    | Irritable Bowel Syndrome
:injcort                | Injection of Corticosteroid
:insomnia               | Insomnia
:intro                  | Introductory Visit
:lowtest                | Low Testosterone
:nailfungus             | Nail Fungus
:noshow                 | No show note
:nosebleed              | Epistaxis
:ocp                    | Oral Contraceptive Refill
:phone                  | Basic phone call
:redeye                 | Red eye
:refill                 | Refill medication
:refills                | Multiple refills for medication
:shingles               | Shingles rash
:sicknote               | Sick Note
:skininfection          | Skin infection
:SOAP                   | Basic SOAP note
:sti                    | STI concern
:stye                   | Hordeolum (Stye)
:strep                  | Strep Throat
:strepphone             | Strep Throat Positive Phonecall
:tremor                 | Tremor
:urti                   | Upper Respiratory Tract Infection
:uti                    | Urine Tract Infection
:uti2                   | Urine Tract Infection (alternate)
:vertigo                | Vertigo
:wrist                  | Wrist Pain

## Contributors
If you are interested in becoming a contributor
contact me by [email](mailto:wressl@gmail.com)

## License
medical-docs was created by Bill Ressl
and is licensed under the [GPL-3.0 license](/LICENSE).
If you decide to use the contents outside of espanso,
contact me by [email](mailto:wressl@gmail.com)

## Disclaimer
The contents of this package is intended only for use by
licensed medical professionals as a tool that may be helpful in their work.
It is provided "as-is" without any guarantee of correctness or completeness.
In particular, it should not be used to diagnose or treat any illness.

