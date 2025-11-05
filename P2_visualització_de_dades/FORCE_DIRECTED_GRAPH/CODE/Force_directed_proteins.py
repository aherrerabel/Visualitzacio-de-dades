import pandas as pd           # Importa la llibreria pandas per treballar amb taules de dades
import networkx as nx         # Importa networkx per crear i visualitzar grafics
import matplotlib.pyplot as plt  # Importa matplotlib per dibuixar els  gràfics
#Llegir el fitxer TSV amb les interaccions de les proteïnes en forma de taula

df = pd.read_csv("/home/andrea/Downloads/string_interactions_short.tsv",sep='\t',)
 # Canvia el nom a 'node1' ja que posa  #node1
if '#node1' in df.columns:    
    df.rename(columns={'#node1': 'node1'}, inplace=True)
 # Crea una nova taula amb només aquestes columnes
df_simple = df[['node1', 'node2', 'combined_score']].copy() 

 # Defineixo valor mínim del "score" per filtrar interaccions
SCORE_THRESHOLD = 0.5 
# Filtra les files amb score >= 0.5
df_filtered = df_simple[df_simple['combined_score'] >= SCORE_THRESHOLD]
 # Gràic
G = nx.from_pandas_edgelist(df_filtered,source='node1',target='node2',edge_attr='combined_score')
 # Calcula la posició dels nodes segons l'algoritme.
pos = nx.spring_layout(G, seed=42, k=0.15) 

plt.figure(figsize=(14, 12))
plt.title(f"Interaccions de les proteïnes (Score $\\geq$ {SCORE_THRESHOLD})", fontsize=16)  
# Dibuixa els nodes 
nx.draw_networkx_nodes(G,pos,node_size=400,node_color='skyblue',alpha=0.9,ax=plt.gca())           

weights = [d['combined_score'] * 3 for (u, v, d) in G.edges(data=True)]  
nx.draw_networkx_edges(G,pos,width=weights,alpha=0.4,edge_color='gray',ax=plt.gca())

nx.draw_networkx_labels(G, pos, font_size=8, font_weight='bold', ax=plt.gca())  

plt.text(0.99, -0.05,"Font de dades: STRING database",fontsize=8,color='gray',ha='right',va='top',transform=plt.gca().transAxes)
plt.axis('off')              
plt.tight_layout()          
plt.savefig("forced_directed_graph.png", dpi=300) 
plt.show()                  
