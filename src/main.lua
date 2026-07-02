local Buffer = require("buffer")
require("produtor")
require("consumidor")

Producao:setProduct()
Consumo:setConsumidor()

local co_produtor = coroutine.create(function()
    Producao:produtor()
end)

local co_consumidor = coroutine.create(function()
    Consumo:consumidor()
end)

print("Iniciando Exemplo 3 - Produtor e Consumidor...")
print("Pressione Ctrl+C para encerrar.\n")

for ciclo = 1, 15 do 
    print("--- Ciclo " .. ciclo .. " ---")
    
    if #Buffer.queue < Buffer.max_size then
        coroutine.resume(co_produtor)
    else
        print("[Semáforo] Produtor bloqueado. O buffer está cheio.")
    end
    
    if #Buffer.queue > 0 then
        coroutine.resume(co_consumidor)
    else
        print("[Semáforo] Consumidor bloqueado. O buffer está vazio.")
    end
    
    os.execute("sleep 1")
    print("")
end

print("Exemplo 3 - Produtor e Consumidor finalizado.")