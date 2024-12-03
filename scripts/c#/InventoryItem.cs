using Godot;

public class InventoryItem : Resource
{
	[Export]
	public string Name { get; set; }

	[Export]
	public Texture2D Texture { get; set; }

	public virtual void Aplicar(PlayerStats stats)
	{
		// Implementación específica en clases derivadas
	}
}
