clear all
close all
clc
% 1:11 for PPG, 12:36 for acc
check = dir('nonfall');

for i = 3 : 17
    tmp = check(i);
    sprintf(tmp.name)
    tmp2 = load(sprintf('nonfall//%s',tmp.name));
    data = tmp2.data;
    tmp3 = load(sprintf('feature_each_user_all//%d.mat',i-2));
    X = tmp3.X;
    y = tmp3.y;
        for j = 1 : size(data,2)
            if isempty(data{size(data,1)-1,j}) == true
                break;
            end
        end
        ind_write = j - 1;
        
        for j = 1 : size(data,2)
            if isempty(data{size(data,1),j}) == true
                break;
            end
        end
        ind_end = j - 1;
        
        for ii = 1 : size(y,1)-1
            if y(ii) ~= y(ii+1)
                break;
            end
        end
        tmp = X(ii- ind_write - ind_end +10 ,:,:,1);  
        tmp = reshape(tmp,[1,36]);
        feature(i-2,:) = tmp;
end

label_normal = uint8(zeros(7,7));
label_fall = uint8(ones(7,7)*255);
for target = 1 : 15
    mkdir(sprintf('user_adaptive_mine_77_corr//test_7_%d',target));
    mkdir(sprintf('user_adaptive_mine_77_corr//test_7_%d//imgs',target));
    mkdir(sprintf('user_adaptive_mine_77_corr//test_7_%d//labels',target));    
    mkdir(sprintf('user_adaptive_mine_77_corr//train_7_%d',target));
    user = target; %for user = 1 : 15
    tmp = check(user+2);
    sprintf(tmp.name)
    tmp2 = load(sprintf('nonfall//%s',tmp.name));
    data = tmp2.data;
    tmp3 = load(sprintf('feature_each_user_all//%d.mat',user));
    X = tmp3.X;
    y = tmp3.y;
        
        X = reshape(X,[size(X,1),36,1,2]);
        ttt = X(:,:,:,1);
        for iii = 1 : size(ttt,1)
            ttt(iii,37:47) = feature(target,1:11);
            ttt(iii,48) = 0;
            ttt(iii,49) = 1;
        end
        clear X tmp
        ttt = reshape(ttt,[iii,7,7,1]);
        X(:,:,:,1) = ttt;
        X(:,:,:,2) = 0;
        
        if user == target
%           save testdata (imgs,labels) in the jj dir
            cnt2 = 0;
            a1 = X;
            for i = 1: size(a1,1)
                b = a1(i,:,:);
                for j = 1 : size(b,2)
                    tmp(j,:) = b(:,:,j);
                end
                img_resize = imresize(tmp,[7,7],'nearest');
                img_resize = rescale(img_resize,0,255);
                img_resize = uint8(img_resize);
                                                
                img_resize2(1,1) = img_resize(7,2);
                img_resize2(1,2) = img_resize(7,3);
                img_resize2(1,3) = img_resize(6,2);
                img_resize2(1,4) = img_resize(6,4);
                img_resize2(1,5) = img_resize(7,4);
                img_resize2(1,6) = img_resize(6,3);
                img_resize2(1,7) = img_resize(6,5);
                                                
                img_resize2(2,1) = img_resize(1,1);
                img_resize2(2,2) = img_resize(1,3);
                img_resize2(2,3) = img_resize(2,3);
                img_resize2(2,4) = img_resize(1,2);
                img_resize2(2,5) = img_resize(1,5);
                img_resize2(2,6) = img_resize(1,6);
                img_resize2(2,7) = img_resize(7,1);
                
                img_resize2(3,1) = img_resize(2,1);
                img_resize2(3,2) = img_resize(2,2);
                img_resize2(3,3) = img_resize(1,4);
                img_resize2(3,4) = img_resize(1,7);
                img_resize2(3,5) = img_resize(2,4);
                img_resize2(3,6) = img_resize(3,2);
                img_resize2(3,7) = img_resize(6,6);
                
                img_resize2(4,1) = img_resize(2,6);
                img_resize2(4,2) = img_resize(5,5);
                img_resize2(4,3) = img_resize(4,1);
                img_resize2(4,4) = img_resize(5,1);
                img_resize2(4,5) = img_resize(3,1);
                img_resize2(4,6) = img_resize(4,6);
                img_resize2(4,7) = img_resize(6,7);
                
                img_resize2(5,1) = img_resize(4,3);
                img_resize2(5,2) = img_resize(3,3);
                img_resize2(5,3) = img_resize(2,5);
                img_resize2(5,4) = img_resize(3,4);
                img_resize2(5,5) = img_resize(2,7);
                img_resize2(5,6) = img_resize(5,3);
                img_resize2(5,7) = img_resize(7,5);
                                
                img_resize2(6,1) = img_resize(5,2);
                img_resize2(6,2) = img_resize(4,5);
                img_resize2(6,3) = img_resize(3,5);
                img_resize2(6,4) = img_resize(4,2);
                img_resize2(6,5) = img_resize(3,7);
                img_resize2(6,6) = img_resize(5,4);
                img_resize2(6,7) = img_resize(7,6);
                
                img_resize2(7,1) = img_resize(4,4);
                img_resize2(7,2) = img_resize(3,6);
                img_resize2(7,3) = img_resize(4,7);
                img_resize2(7,4) = img_resize(5,7);               
                img_resize2(7,5) = img_resize(6,1);
                img_resize2(7,6) = img_resize(5,6);
                img_resize2(7,7) = img_resize(7,7);
                
                
                
                img_resize2 = uint8(img_resize2);
                
                
                
                
                if cnt2 < 10
                    ind = strcat('00',int2str(cnt2));
                elseif cnt2 < 100 && cnt2 >=10
                    ind = strcat('0',int2str(cnt2));
                else
                    ind = int2str(cnt2);
                end
               if y(i,1) == 0
                   if mod(cnt2,7) == 0 || mod(cnt2,7) == 1
                   imwrite(img_resize2,sprintf('user_adaptive_mine_77_corr//test_7_%d//imgs//img_%d_%s.jpg',target,user-1,ind),'Quality',100);
                   imwrite(label_normal, sprintf('user_adaptive_mine_77_corr//test_7_%d//labels//label_%d_%s.jpg',target,user-1,ind),'Quality',100);
%                   img = imread(sprintf('user_adaptive_mine_77//test_7_%d//imgs//img_%d_%s.jpg',target,user-1,ind))
                   cnt2 = cnt2 + 1;             
                   else
                   imwrite(img_resize2,sprintf('user_adaptive_mine_77_corr//train_7_%d//img_%d_%s.jpg',target,user-1,ind),'Quality',100);
                   cnt2 = cnt2 + 1;   
                       
                   end
               elseif y(i,1) == 1 
                   imwrite(img_resize2,sprintf('user_adaptive_mine_77_corr//test_7_%d//imgs//img_%d_%s.jpg',target,user-1,ind),'Quality',100);
                   imwrite(label_fall, sprintf('user_adaptive_mine_77_corr//test_7_%d//labels//label_%d_%s.jpg',target,user-1,ind),'Quality',100);
                  cnt2 = cnt2 + 1;              
               end
                
            end      

        end   
        
%    end
    
end
