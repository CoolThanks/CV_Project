function  tcp_connect()
    %% tcp stuff

    t = tcpip('127.0.0.1', 10000, 'NetworkRole', 'server');
    fopen(t);
    fprintf("connected\n");
    for i=1:3
    fwrite(t, "good");
    %     x = fscanf(t);
    %     fprintf('%s',x);
    %     if x == "done"
    %         break;
    %     end
    pause(1);
    end
    fwrite(t,"done");
    fclose(t);
end