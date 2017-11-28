function [ match, nextStart ] = evaluate( pics, nextStart, ymom, mmom, cmom, amom, avgimgNs,count)
    length = size(pics, 3);
    if  length > 1
        outputMHI = generateMHI(pics, nextStart, false);
    else
        match = "next";
        return;
    end
%     figure(1);
%     imagesc(outputMHI);
    vals = similitudeMoments(outputMHI);
%     close(1);
    for i = 1:7
        differences(i) = abs(avgimgNs(i) - vals(i));
    end
    motionMatch = min([sum(abs(ymom-differences)),sum(abs(mmom-differences)),...
        sum(abs(cmom-differences)),sum(abs(amom-differences))]);
    if ((sum(differences<ymom) >= 6) && motionMatch == abs(ymom-differences)...
            && count == 1)
        match = "good";
        return;
    else
        if ((sum(differences<mmom) >= 6) && motionMatch == ...
            abs(mmom-differences) && count == 2)
             match = "good";
            return;
        else
            if ((sum(differences<cmom) >= 6) && motionMatch == ...
                    abs(cmom-differences) && count == 3)
                match = "good";
                return;
            else
                if ((sum(differences<amom) >= 6) && motionMatch == ...
                        abs(amom-differences) && count == 4)
                    match = "good";
                    return;
            end
        end
    end
    if ((length > 25 && count == 1) || (length > 35 && count == 2) || ...
            (length > 45 && count == 3) || (length > 50 && count == 4))
        match = "bad";
        figure(length);
        imagesc(outputMHI);
        if(length > 25)
            nextStart = 15
        else
            if (length > 35)
                nextStart = 25
            else
                if (length > 45)
                    nextStart = 35
                end
            end
        end
        return;
    end
    match =  "next";
end

