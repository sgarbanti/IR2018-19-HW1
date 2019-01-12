%% SGARBANTI TOMMASO
%% 1185058
clc
close all
clear all
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
filesEV = [ "BM25_+SL+PS_eval.txt" "BM25_-SL+PS_eval.txt" "TF*IDF_+SL+PS_eval.txt" "TF*IDF_-SL-S_eval.txt" ];
runID   = ["BM25_+SL+PS" "BM25_-SL+PS" "TF*IDF_+SL+PS" "TF*IDF_-SL-S" ];

patternAP    = "map ";
patternP10   = "P_10 ";
patternRprec = "Rprec ";
AP    = [];
P10   = [];
Rprec = [];

for fileEV = filesEV
    text = fileread( "eval_run/" + fileEV );
    text = splitlines( text );
    
    APtext   = char( text(startsWith(text, patternAP)) );
    APvalues = str2num( APtext(:,end-5:end));
    AP       = [ AP APvalues ];

    P10text   = char( text(startsWith(text, patternP10)) );
    P10values = str2num( P10text(:,end-5:end));
    P10       = [ P10 P10values];

    RprecText   = char( text(startsWith(text, patternRprec)) );
    RprecValues = str2num( RprecText(:,end-5:end));
    Rprec       = [ Rprec RprecValues ];
end

% average measures
APmean   = AP(end, :);
P10mean  = P10(end, :);
RprecMean = Rprec(end, :);
% measures of topics
AP    = AP(1:end-1, :);
P10   = P10(1:end-1, :);
Rprec = Rprec(1:end-1, :);

tblMeans = table((runID)', APmean', P10mean', RprecMean');
tblMeans.Properties.VariableNames = {'RUN_ID' 'MAP' 'P_10' 'R_PREC'};
disp( tblMeans )

% Average Precision boxplot
figure
boxplot(AP, runID)
title('Average Precision (AP)')

pause(1) % to avoid title bug (no title in next boxplot)

% Precision at 10 boxplot
figure
boxplot(P10, runID)
title('Precision at 10 (P\_10)')

pause(1) % to avoid title bug (no title in next boxplot)

% precision at RB boxplot
figure
boxplot(Rprec, runID)
title('Precision at RB (Rprec)')

%% MAP TESTS
% sort in descending order of mean score
[~, idx] = sort(APmean, 'descend');
% re-order runs to have a better looking boxplot
AP = AP(:, idx);
APrunID = runID;
APrunID = APrunID(idx);

% perform ANOVA 1-way test
[~, APtbl, APsts] = anova1(AP, APrunID, 'off');
% display the ANOVA table
disp( "Anova table per la MAP:" )
disp( APtbl )

figure
% perform Tukey test
[APc,~,~,gnames] = multcompare(APsts, 'Alpha', 0.05, 'Ctype', 'hsd');
title({'Average Precision (AP)'; 'Click on the group you want to test'})
% display the comparisons
disp( "Confronti del test di Tukey per la MAP:" )
disp( "        |1-RUN|            |2-RUN|        |L-LIMIT|       |DIFF|       |U-LIMIT|   |P-VAL|" )
disp( [gnames(APc(:,1)), gnames(APc(:,2)), num2cell(APc(:,3:6))] )

%% P_10 TESTS
% sort in descending order of mean score
[~, idx] = sort(P10mean, 'descend');
% re-order runs to have a better looking boxplot
P10 = P10(:, idx);
P10runID = runID;
P10runID = P10runID(idx);

% % perform ANOVA 1-way test
[~, P10tbl, P10sts] = anova1(P10, P10runID, 'off');
% display the ANOVA table
disp( "Anova table per la P_10:" )
disp( P10tbl )

figure
% perform Tukey test
[P10c,~,~,gnames] = multcompare(P10sts, 'Alpha', 0.05, 'Ctype', 'hsd');
title({'Precision at 10 (P\_10)'; 'Click on the group you want to test'})
% display the comparisons
disp( "Confronti del test di Tukey per la P_10:" )
disp( "        |1-RUN|            |2-RUN|        |L-LIMIT|       |DIFF|       |U-LIMIT|   |P-VAL|" )
disp( [gnames(P10c(:,1)), gnames(P10c(:,2)), num2cell(P10c(:,3:6))] )

%% Rprec TESTS
% sort in descending order of mean score
[~, idx] = sort(RprecMean, 'descend');
% re-order runs to have a better looking boxplot
Rprec = Rprec(:, idx);
RprecRunID = runID;
RprecRunID = RprecRunID(idx);

% % perform ANOVA 1-way test
[~, RprecTbl, RprecSts] = anova1(Rprec, RprecRunID, 'off');
% display the ANOVA table
disp( "Anova table per la Rprec:" )
disp( RprecTbl )

figure
% perform Tukey test
[RprecC,~,~,gnames] = multcompare(RprecSts, 'Alpha', 0.05, 'Ctype', 'hsd');
title({'Precision at RB (Rprec)'; 'Click on the group you want to test'})
% display the comparisons
disp( "Confronti del test di Tukey per la Rprec:" )
disp( "        |1-RUN|            |2-RUN|        |L-LIMIT|       |DIFF|       |U-LIMIT|   |P-VAL|" )
disp( [gnames(RprecC(:,1)), gnames(RprecC(:,2)), num2cell(RprecC(:,3:6))] )