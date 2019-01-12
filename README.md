# IR2018-19-HW1
A project of the Information_Retrieval(IR) course of University_of_Padua(UniPD) 

## What constitutes this project?
This project is an evaluation of 2 different IR models wich each of them with 2 different configurations for a total of 4 runs.
The TREC7 collection was used and each run had retrieved documents for 50 given queries.
The model was evaluated and the ANOVA 1-way statistic test was performed, at the end also the Tukey test was computed.

The 4 retrieval configurations are:
* BM25_+SL+PS   : BM25 model   - Stoplist    , PortStemmer
* BM25_-SL+PS   : BM25 model   - NO_Stoplist , PortStemmer
* TF*IDF_+SL+PS : TF_IDF model - Stoplist    , PortStemmer
* TF*IDF_-SL-S  : TF_IDF model - NO_Stoplist , NO_Stemmer

In the "EVALUATION" folder there are evaluations files, graphs and the tests script (matlab code).
Configuration files (.properties files) and the files of runs are in the respective folders of the different configurations tested.

### Softwares used
* Terrier v4.4
* Matlab R2018b
* trec_eval.9.0


______________________________

Tommaso Sgarbanti
tommaso.sgarbanti@studenti.unipd.it
