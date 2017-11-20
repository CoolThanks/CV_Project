tcp_connection = tcpip('127.0.0.1', 10000, 'NetworkRole', 'server');
fopen(tcp_connection);
fprintf("Connected...\n");
for i=1:4
    fwrite(tcp_connection,"Good");
    pause(1);
end
fprintf("Finished! Closing connection...\n");
fclose(tcp_connection);