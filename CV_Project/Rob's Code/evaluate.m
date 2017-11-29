function [ match, nextStart, pics, pics2 ] = evaluate( pics, pics2, ...
    nextStart, ymom, mmom, cmom, amom, yavgimgNs,mavgimgNs,cavgimgNs,aavgimgNs,count)
    length = size(pics, 3);
    if  length > 1
       [outputMHI,pics,pics2,nextStart] = generateMHI2(pics, pics2, nextStart, false, .25);
    else
        match = "next";
        return;
    end
%     figure(1);
%     imagesc(outputMHI);
    vals = similitudeMoments(outputMHI)
%     close(1);
    for i = 1:7
        differencesy(i) = abs(yavgimgNs(i) - vals(i));
        differencesm(i) = abs(mavgimgNs(i) - vals(i));
        differencesc(i) = abs(cavgimgNs(i) - vals(i));
        differencesa(i) = abs(aavgimgNs(i) - vals(i));
    end
    motionMatch = min([sum(abs(ymom-differencesy)),sum(abs(ymom-differencesm)),...
        sum(abs(ymom-differencesc)),sum(abs(ymom-differencesa))]);
    if (motionMatch == sum(abs(ymom-differencesy))...
            && count == 1) % (sum(differencesy<ymom*4) >= 4) && 
        match = "good";
        return;
    else
        if (motionMatch == ...
            sum(abs(mmom-differencesm)) && count == 2)
             match = "good";
            return;
        else
            if (motionMatch == ...
                    sum(abs(ymom-differencesc)) && count == 3)
                match = "good";
                return;
            else
                if (motionMatch == ...
                        sum(abs(ymom-differencesa)) && count == 4)
                    match = "good";
                    return;
            end
        end
    end
    if ((length > 20 && count == 1) || (length > 30 && count == 2) || ...
            (length > 40 && count == 3) || (length > 45 && count == 4))
        match = "bad";
        if (motionMatch == sum(abs(ymom-differencesa)))
            fprintf('got A\n');
        else
            if (motionMatch == sum(abs(ymom-differencesy)))
            fprintf('got Y\n');
            else
                if (motionMatch == sum(abs(ymom-differencesc)))
                    fprintf('got C\n');
                else
                    fprintf('got M\n');
                end
            end
        end
        figure(length);
        imagesc(outputMHI);
%         if(length > 25)
%             nextStart = 15
%         else
%             if (length > 35)
%                 nextStart = 25
%             else
%                 if (length > 45)
%                     nextStart = 35
%                 end
%             end
%         end
        return;
    end
    match =  "next";
end

