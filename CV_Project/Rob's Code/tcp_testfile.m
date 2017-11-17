t = tcpip('localhost', 10000, 'NetworkRole', 'client');
fopen(t);
score = 0;
check = "ok";
while(check ~= "done")
    check = fread(t);
    if(check == "good")
        score = score + 500;
    end
    fwrite(t,"ok")
end