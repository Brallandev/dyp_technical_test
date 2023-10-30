import { Component, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Client } from './models/client.model';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'dyp-test';
  http = inject(HttpClient);
  clients: Client[] = [];

  changeTitle() {
    this.title = 'changed';
  }

  ngOnInit() {
    this.http.get<Client[]>('http://localhost:8000/api/clientes')
    .subscribe((data) => {
      this.clients = data;
    });
  }

}
