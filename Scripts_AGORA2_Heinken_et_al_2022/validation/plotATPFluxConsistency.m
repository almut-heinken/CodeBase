%% plot ATP production

load([rootDir filesep 'Comparison_other_GEMs' filesep 'Results' filesep 'ATP_production.mat'])

table={};
resources=fieldnames(atp);
cnt=1;
cats={'AGORA2','KBase','BiGG','CarveMe','gapseq','MAGMA'};

for i=1:length(resources)
    for j=1:length(atp.(resources{i}))
        table{cnt,1}='Aerobic medium';
        table{cnt,2}=resources{i};
        table{cnt,3}=atp.(resources{i})(j,1);
        cnt=cnt+1;
        table{cnt,1}='Anaerobic medium';
        table{cnt,2}=resources{i};
        table{cnt,3}=atp.(resources{i})(j,2);
        cnt=cnt+1;
    end
end

table=cell2table(table,'VariableNames',{'Feature','Resource','Value'});
table.Resource=categorical(table.Resource,cats);

figure
boxchart(table.Resource,table.Value,'GroupByColor',table.Feature)
legend
ylim([0 1000])
ylabel('mmol * g dry weight-1 * hr-1')
title('ATP production on aerobic and anaerobic complex medium')
set(gca,'FontSize',16)
print('ATP_production_boxchart','-dpng','-r300')

%% plot stoichiometric and flux consistency

load([rootDir filesep 'Comparison_other_GEMs' filesep 'Results' filesep 'Stoch_Flux_Consistency.mat']);

table={};
resources=fieldnames(SFconsist);
cnt=1;
cats={'AGORA2','KBase','BiGG','CarveMe','gapseq','MAGMA'};

for i=1:length(resources)
    for j=1:length(SFconsist.(resources{i}))
        table{cnt,1}='Stoichiometric consistency';
        table{cnt,2}=resources{i};
        table{cnt,3}=SFconsist.(resources{i})(j,3);
        cnt=cnt+1;
        table{cnt,1}='Flux consistency';
        table{cnt,2}=resources{i};
        table{cnt,3}=SFconsist.(resources{i})(j,4);
        cnt=cnt+1;
    end
end

table=cell2table(table,'VariableNames',{'Feature','Resource','Value'});
table.Resource=categorical(table.Resource,cats);

figure
boxchart(table.Resource,table.Value,'GroupByColor',table.Feature)
legend
title('Fraction of stoichiometrically and flux consistent reactions')
set(gca,'FontSize',16)
print('Flux_consistency_boxchart','-dpng','-r300')

%% export flux and stoichiometric consistency for AGORA2 vs. KBase

dInfo = dir(fullfile([rootDir filesep 'Current_Version_AGORA2' filesep 'Output_Models'], '**/*.*'));  %get list of files and folders in any subfolder
dInfo = dInfo(~[dInfo.isdir]);
models={dInfo.name};
models=models';
models(find(~contains(models,'.mat')),:)=[];
models=strrep(models,'.mat','');

table={'Model_ID','StoichConsist_KBase','FluxConsist_KBase','StoichConsist_AGORA2','FluxConsist_AGORA2'};
table(2:length(models)+1,1)=models;
table(2:length(models)+1,2)=cellstr(num2str(SFconsist.('KBase')(:,2)));
table(2:length(models)+1,3)=cellstr(num2str(SFconsist.('KBase')(:,4)));
table(2:length(models)+1,4)=cellstr(num2str(SFconsist.('AGORA2')(:,2)));
table(2:length(models)+1,5)=cellstr(num2str(SFconsist.('AGORA2')(:,4)));

cell2csv('Stoich_Flux_Consistency_KBase_AGORA2.csv',table)