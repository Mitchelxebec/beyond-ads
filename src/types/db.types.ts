export interface Advertiser {
  id: string;
  name: string;
  email: string;
  createdAt: Date;
}

export interface Campaign {
  id: string;
  advertiserId: string;
  name: string;
  totalBudget: number;
  spent: number;
  startDate: Date;
  endDate: Date;
  status: "active" | "paused" | "ended"; // Using literal types to enforce your CHECK constraint rules!
  targetCountries: string[]; // Maps perfectly to text[]
  targetDevices: string[]; // Maps perfectly to text[]
  minAge: number;
  maxAge: number;
  createdAt: Date;
}

export interface Ad {
  id: string;
  campaignId: string;
  imageUrl: string;
  clickUrl: string;
  width: number;
  height: number;
  createdAt: Date;
}

export interface Publisher {
  id: string;
  name: string;
  createdAt: Date;
}

export interface Placement {
  id: string;
  publisherId: string;
  name: string;
  width: number;
  height: number;
  createdAt: Date;
}
