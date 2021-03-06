using UnityEngine;
using System.Collections;

public class DestroyByContactMain : MonoBehaviour 
{
	public GameObject explosion;
	public GameObject playerExplosion;

	public int scoreValue;
	private GameControllerMain gameController;

	void Start ()
	{
		GameObject gameControllerObject = GameObject.FindWithTag ("GameControllerMain");
		if (gameControllerObject != null)
		{
			gameController = gameControllerObject.GetComponent <GameControllerMain> ();
		}
		if (gameControllerObject == null)
		{
			Debug.Log ("Cannot Find 'GameController' script");
		}
	}
	void OnTriggerEnter(Collider other)
	{
		if (other.tag == "Boundary")
		{
			return;
		}
			
		Instantiate (explosion, transform.position, transform.rotation);

		if (other.tag == "Player") 
		{
			Instantiate (playerExplosion, other.transform.position, other.transform.rotation);
		    gameController.GameOver ();
		}
		gameController.AddScore (scoreValue);
		Destroy (other.gameObject);
		Destroy (gameObject);
	}
}
