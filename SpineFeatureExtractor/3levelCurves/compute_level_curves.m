function compute_level_curves(root_spines_neck_repaired_path,number_of_ranges,remove,threshold)
%COMPUTE_LEVEL_CURVES Computes level curves for all the spines under a root
%folder.
%
%   COMPUTE_LEVEL_CURVES(root_spines_neck_repaired_path, number_of_ranges,
%   remove, threshold) Given root_spines_neck_repaired_path which is the
%   folder where spines with repaired neck are stored, level curves will be
%   computed for them. The number of computed level curves is defined by
%   number_of_ranges. If remove is TRUE, those spines with double curve
%   defect will be removed. Threshold is used to decide when double curve
%   defect exists. The smaller the threshold value, the more the number of
%   double curve defects detected.
%
%Author: Luengo-Sanchez, S.
%
%See also COMPUTE_SPINE_CURVES, DETECT_DOUBLE_CURVE

    list_dendrites = dir(root_spines_neck_repaired_path);

    for i=3:size(list_dendrites,1)
        dendrite_name = list_dendrites(i).name;
        list_spines = dir([root_spines_neck_repaired_path filesep dendrite_name]);
        
        for j=3:size(list_spines, 1)
            spine_name = list_spines(j).name;
            spine_path = [root_spines_neck_repaired_path filesep dendrite_name filesep spine_name];
            spine_data = load(spine_path);
            compute_spine_curves(spine_path, spine_data, number_of_ranges);    
        end
    end
    
    if(remove)
        [spine_path,~]=detect_double_curve(root_spines_neck_repaired_path,threshold);
        spine_path=unique(spine_path);
        for(i=1:length(spine_path))  
            delete(spine_path{i});
        end
    end 
end

