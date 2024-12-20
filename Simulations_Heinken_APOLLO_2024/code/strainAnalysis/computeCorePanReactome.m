
% compute core-and pan-reactome 

clear all
rootDir = pwd;

loadedData = parquetread([rootDir filesep 'data' filesep 'analysis_ModelProperties' filesep 'Pasolli_Almeida_parquet_files' filesep 'reactionPresence_combined_refined.parquet']);

% load all strain taxonomy data
info_Pasolli=readInputTableForPipeline([rootDir filesep 'input' filesep 'Pasolli_genomes_taxonomy_info.txt']);
strain_names = cellstr(table2cell(loadedData(:,end)));
loadedData(:,end)=[];
rxnNames = loadedData.Properties.VariableNames;

% remove any AGORA2 strains
[~,IA]=setdiff(info_Pasolli(:,1),strain_names,'stable');
info_Pasolli(IA(2:end),:)=[];
info_Almeida=readInputTableForPipeline([rootDir filesep 'input' filesep 'Almeida_genomes_taxonomy_info.txt']);
% remove any AGORA2 strains
[~,IA]=setdiff(info_Almeida(:,1),strain_names,'stable');
info_Almeida(IA(2:end),:)=[];

Core_pan_reactions=struct;

% create a table with information on pan and core reactome for each taxon
taxStats={'Taxon','Number of taxa','Reactions in core reactome','Reactions in pan-reactome'};
% get the list of all taxa on this taxon level
taxCol_Pasolli=find(strcmp(info_Pasolli(1,:),'Species'));
allTax=unique(info_Pasolli(2:end,taxCol_Pasolli));
taxCol_Almeida=find(strcmp(info_Almeida(1,:),'Species'));
allTax=union(allTax,unique(info_Almeida(2:end,taxCol_Almeida)));

% removed unspecified taxa
TF = endsWith(allTax,' sp');
allTax(find(TF==true),:)=[];
TF = endsWith(allTax,' unclassified');
allTax(find(TF==true),:)=[];
TF = endsWith(allTax,' bacterium');
allTax(find(TF==true),:)=[];
allTax(find(strcmp(allTax,'')),:)=[];
allTax(find(strcmp(allTax,'N/A')),:)=[];
allTax(find(strcmp(allTax,'NA')),:)=[];

for j=1:length(allTax)
    j
    taxStats{j+1,1}=allTax{j};
    % get the reaction patterns for each strain in the taxon
    reacPat={};
    findInPasolli=find(strcmp(info_Pasolli(:,taxCol_Pasolli),allTax{j}));
    findInAlmeida=find(strcmp(info_Almeida(:,taxCol_Almeida),allTax{j}));
    
    % report total number of strains
    taxStats{j+1,2}=length(findInPasolli)+length(findInAlmeida);
    
    for k=1:length(findInPasolli)
        % get reactions in this strain
        findInData=find(strcmp(strain_names,info_Pasolli{findInPasolli(k),1}));
        reacPat{length(reacPat)+1,1}=rxnNames(find(cell2mat(table2cell(loadedData(findInData,:)))==1));
    end
    for k=1:length(findInAlmeida)
        % get reactions in this strain
        findInData=find(strcmp(strain_names,info_Almeida{findInAlmeida(k),1}));
        reacPat{length(reacPat)+1,1}=rxnNames(find(cell2mat(table2cell(loadedData(findInData,:)))==1));
    end
    % get the pan-reactome of all strains
    pan_rxns={};
    for k=1:length(reacPat)
        pan_rxns=union(pan_rxns,reacPat{k,1});
    end
    taxStats{j+1,4}=length(pan_rxns);
    
    % get the core reactome of all strains
    core_rxns={};
    for k=1:length(pan_rxns)
        incore=1;
        for l=length(reacPat)
            if isempty(intersect(pan_rxns{k},reacPat{l}))
                incore=0;
            end
        end
        if incore==1
            core_rxns{length(core_rxns)+1,1}=pan_rxns{k};
        end
    end
    taxStats{j+1,3}=length(core_rxns);
    fieldname=strrep(allTax{j},' ','_');
    fieldname=strrep(fieldname,'.','');
    fieldname=strrep(fieldname,'-','_');
    Core_pan_reactions.('Species').(fieldname).('pan_rxns')=pan_rxns;
    Core_pan_reactions.('Species').(fieldname).('core_rxns')=core_rxns;
end

% export the table
writetable(cell2table(taxStats),[rootDir filesep 'data' filesep 'analysis_ModelProperties' filesep 'Core_pan_reactome_Species.csv'],'WriteVariableNames',false)

% export the lists of reactions
save([rootDir filesep 'data' filesep 'analysis_ModelProperties' filesep 'Core_pan_reactions.mat'],'Core_pan_reactions')
