function [max_value,mean_value] = compute_euclidian(ref,signal)

    L1 = ref(:,:,1);
    L2 = signal(:,:,1);
    a1 = ref(:,:,2);
    a2 = signal(:,:,2);
    b1 = ref(:,:,3);
    b2 = signal(:,:,3);


    euclidian = sqrt(((L1-L2).^2) + ((a1-a2).^2) + ((b1-b2).^2)); 
    
    max_value = max(max(euclidian));
    mean_value = mean(mean(euclidian)); 
end

