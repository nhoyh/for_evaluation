clear all
close all
clc

mkdir('for_20_20_test');
for i = 1:15
    mkdir(sprintf('for_20_20_test//test_7_%d',i));
    mkdir(sprintf('for_20_20_test//test_7_%d//imgs',i));
    mkdir(sprintf('for_20_20_test//test_7_%d//labels',i));
    
    fold = dir(sprintf('user_adaptive_mine_77_corr//test_7_%d//labels',i));
    for j = 3 : size(fold,1)
       label_pix = imread(sprintf('user_adaptive_mine_77_corr//test_7_%d//labels//%s',i,fold(j).name)); 
       if sum(label_pix(:,1)) > 255
            break;
       end
    end
    nf_rand = randperm(j-4,20)+3; %random select 20 in nf
    f_rand = randperm(size(fold,1)-j, 20) + j;
    
    img_path = sprintf('user_adaptive_mine_77_corr//test_7_%d//imgs',i);
    label_path = sprintf('user_adaptive_mine_77_corr//test_7_%d//labels',i);
    dest_path = sprintf('for_20_20_test//test_7_%d//imgs',i);
    dest_path_label = sprintf('for_20_20_test//test_7_%d//labels',i);
    sourcedir = dir(img_path);
    sourcedir_label = dir(label_path);
    
    for ii = nf_rand
        sourcefile = fullfile(img_path, sourcedir(ii).name);
        destfile = fullfile(dest_path, sourcedir(ii).name);
        copyfile(sourcefile,destfile);
        
        sourcefile = fullfile(label_path, sourcedir_label(ii).name);
        destfile = fullfile(dest_path_label, sourcedir_label(ii).name);
        copyfile(sourcefile,destfile);
    end
        
    for ii = f_rand
        sourcefile = fullfile(img_path, sourcedir(ii).name);
        destfile = fullfile(dest_path, sourcedir(ii).name);
        copyfile(sourcefile,destfile);
        
        sourcefile = fullfile(label_path, sourcedir_label(ii).name);
        destfile = fullfile(dest_path_label, sourcedir_label(ii).name);
        copyfile(sourcefile,destfile);
    end
    
end