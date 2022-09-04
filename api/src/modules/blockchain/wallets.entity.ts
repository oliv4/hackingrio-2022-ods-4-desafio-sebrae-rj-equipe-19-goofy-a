import {
  Column,
  CreateDateColumn,
  Entity,
  Index,
  JoinColumn,
  OneToOne,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { UsersEntity } from '../users/users.entity';

@Entity('wallets')
export class WalletsEntity {
  @PrimaryGeneratedColumn('uuid')
  public id: string;

  @Column({ type: 'char', length: 42, nullable: false })
  @Index('wallet_address_idx', { unique: true })
  public address: string;

  @Column({ name: 'private_key', type: 'varchar', length: 255, nullable: true })
  public privateKey: string;

  @Column({ name: 'public_key', type: 'varchar', length: 255, nullable: true })
  public publicKey: string;

  @Column({ type: 'varchar', nullable: true })
  public mnemonic: string;

  @Column({ name: 'user_id', type: 'uuid', nullable: false })
  public userId: string;

  @Column({
    name: 'is_active',
    type: 'boolean',
    default: true,
    nullable: false,
  })
  public isActive: boolean;

  @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
  public createdAt: Date;

  @UpdateDateColumn({ name: 'updated_at', type: 'timestamptz', nullable: true })
  public updatedAt: Date;

  @OneToOne(() => UsersEntity, (user) => user.wallet)
  @JoinColumn({ name: 'user_id' })
  user: UsersEntity;
}
